class Install
  class NewApp

    include ActiveModel::Model
    extend ApplicationRecord::CustomAttributeLabels

    attr_accessor :engines_system,
                  :repository_url,
                  :library_id

    attr_writer   :install_metadata,
                  :app_label,
                  :app_icon_url,
                  :label,
                  :install_form_comment,
                  :container_name,
                  :host_name,
                  :domain_name,
                  :http_protocol,
                  :memory,
                  :recommended_memory,
                  :required_memory,
                  :deployment_type,
                  :license_label,
                  :license_sourceurl,
                  :license_accept

    custom_attribute_labels http_protocol: "HTTP Protocol"

    validate :container_name_not_reserved
    validate :fqdn_not_reserved
    validates :label, presence: true, length: { maximum: 32 }
    validates :container_name, presence: true, length: { maximum: 16 }
    validates :host_name, presence: true, format: { with: /\A[a-z0-9\-]+\z/ }, length: { maximum: 32 }
    validates :domain_name, presence: true
    validates :http_protocol, presence: true
    validate :memory_valid
    validate :environment_variables_valid
    validates :license_accept, acceptance: { message: [['License', 'must be accepted']] }

    def app_label
      @app_label ||=
      if install_metadata[:data][:method].to_sym == :gui_library
        install_metadata[:data][:app][:label]
      else
        blueprint[:software][:base][:name].to_s.humanize
      end
    end

    def app_icon_url
      @app_icon_url ||=
      if install_metadata[:data][:method].to_sym == :gui_library
        install_metadata[:data][:app][:icon_url]
      else
        ''
      end
    end

    def install_metadata
      @install_metadata ||= { schema: '0.1', data: {} }
    end

    def install_form_comment
      @install_form_comment ||= blueprint[:software][:base][:install_form_comment]
    end

    def custom_install
      @custom_install ||= false
    end

    def custom_install=bool
      @custom_install = bool
    end

    def domains_collection=json
      @domains_collection ||= JSON.parse(json)
    end

    def reserved_fqdns=json
      @reserved_fqdns ||= JSON.parse(json)
    end

    def reserved_container_names=json
      @reserved_container_names ||= JSON.parse(json)
    end

    def environment_variables_valid
      @environment_variables.valid?
    end

    def memory_valid
      if memory.to_i < required_memory.to_i
        errors.add(:memory, "must be at least #{required_memory}")
      end
    end

    def to_label
      app_label
    end

    def container_name
      @container_name ||= available_name_for blueprint[:software][:base][:name]
    end

    def label
      @label ||= app_label || container_name.humanize
    end

    def host_name
      @host_name ||= container_name.gsub('_','-')
    end

    def domain_name
      @domain_name ||= engines_system.default_domain
    end

    def domains_collection
      @domains_collection ||=
      engines_system.domains.map{|domain| [domain[:domain_name]]}
    end

    def http_protocol
      @http_protocol ||=
      [:http_only, :https_only, :http_and_https, :https_and_http].
      include?(blueprint[:software][:base][:http_protocol].to_s.to_sym) ?
      blueprint[:software][:base][:http_protocol].to_sym : :http_and_https
    end

    def protocol_select_collection
      case http_protocol.to_sym
      when :http_only
        [ [:http_only, 'HTTP only'] ]
      when :https_only
        [ [:https_only, 'HTTPS only'] ]
      else
        [ [:https_and_http, 'HTTPS and HTTP'],
          [:http_and_https, 'HTTP and HTTPS'],
          [:https_only, 'HTTPS only'],
          [:http_only, 'HTTP only'] ]
      end
    end

    def memory
      @memory ||= blueprint[:software][:base][:memory][:recommended] || blueprint[:software][:base][:memory][:required]
    end

    def recommended_memory
      @recommended_memory ||= blueprint[:software][:base][:memory][:recommended]
    end

    def required_memory
      @required_memory ||= blueprint[:software][:base][:memory][:required]
    end

    def memory_hint
      @memory_hint ||=
      if recommended_memory.present?
        recommended_memory.to_s + ' recommended. '
      end.to_s +
      "#{required_memory} minimum."
    end

    def license_accept
      @license_accept ||= false
    end

    def deployment_type
      @deployment_type ||= blueprint[:software][:base][:deployment_type]
    end


    # blueprint

    def repository_blueprint
      EnginesRepositories::Blueprint.new(repository_url).blueprint
    end

    def blueprint
      @blueprint ||= Conform::AppBlueprint.new(repository_blueprint).schema1_0
    end

    def license_label
      @license_label ||= blueprint[:metadata][:software][:license][:label] || 'License'
    end

    def license_sourceurl
      @license_sourceurl ||= blueprint[:metadata][:software][:license][:url]
    end

    def environment_variables
      @environment_variables ||= EnvironmentVariables.new(new_app: self)
    end

    def environment_variables_attributes=(build_params)
      @environment_variables ||=
        EnvironmentVariables.new(build_params.merge(new_app: self))
    end

    def service_consumers
      @service_consumers ||=
      service_consumers_build_params.map do |service_consumer|
        ServiceConsumer.new(service_consumer.merge(new_app: self))
      end.select { |service_consumer| service_consumer.persistent? }
    end

    def service_consumers_attributes=(build_params)
      @service_consumers ||=
      build_params.map do |i, service_consumer|
        ServiceConsumer.new(service_consumer.merge(new_app: self))
      end
    end

    def service_consumers_build_params
      service_consumers = blueprint[:software][:service_configurations]
      return [] unless service_consumers.present?
      service_consumers.map do |service_consumer|
        { type_path: "#{service_consumer[:publisher_namespace]}/#{service_consumer[:type_path]}",
          create_type: :new }
      end
    end

    def available_name_for(default_name)
      name = default_name
      index = 2
      while reserved_container_names.include? name do
        max_base_length = 16 - index.to_s.length
        name = default_name.first(max_base_length) + index.to_s
        index += 1
      end
      name
    end

    def reserved_container_names
      @reserved_container_names ||= core_system.reserved_container_names
    end

    def reserved_fqdns
      @reserved_fqdns ||= core_system.reserved_fqdns
    end

    def install
      core_system.build_app(app_install_params)
    end

    def create_app
      @app = engines_system.apps.where(name: container_name).first_or_create
      set_app_display_properties

      @app.save
    end

    def set_app_display_properties
      @app.label = label[0..31]
      @app.show_on_portal = true
      unless deployment_type.to_sym == :web
      #   @app.portal_link = "#{http_protocol.include?('https') ? 'https' : 'http'}://#{host_name}.#{domain_name}"
      # else
        @app.worker = true
      end
      @app.icon = Utilities::FileLoader.get @app_icon_url
    end

    def app_install_params
      { engine_name: container_name,
        host_name: host_name,
        domain_name: domain_name,
        http_protocol: http_protocol.to_s,
        memory: memory,
        variables: variables_install_params,
        attached_services: service_consumers_install_params,
        repository_url: repository_url,
        install_metadata: install_metadata }
      end

      def variables_install_params
        {}.tap do |result|
          environment_variables.fields.each do |field|
            result[field.attribute_name] = field.value_for_system
          end
        end
      end

      def service_consumers_install_params
        service_consumers.map do |service_consumer|
          publisher_namespace, base_type_path = service_consumer.type_path.split('/', 2)
          { publisher_namespace: publisher_namespace,
            type_path: base_type_path,
            create_type: service_consumer.create_type,
            parent_engine: service_consumer.parent_app_for_selected,
            service_handle: service_consumer.service_handle_for_selected }
        end
      end

      def container_name_not_reserved
        if reserved_container_names.include? container_name
          errors.add(:container_name, "'#{container_name}' is already in use")
          @custom_install = true   # ensure that form showing all fields
        end
      end

      def fqdn_not_reserved
        if reserved_fqdns.include? "#{host_name}.#{domain_name}"
          errors.add(:base, "FQDN '#{host_name}.#{domain_name}' is already in use")
          @custom_install = true
        end
      end

      def core_system
        engines_system.core_system
      end

  end
end
