class App
  module Properties

  # blueprint

    def blueprint
      @blueprint ||= Conform::AppBlueprint.new(app_blueprint).schema1_0
    end

    def app_blueprint
      @app_blueprint ||= core_app.blueprint
    end

    def has_old_blueprint
      app_blueprint.dig(:schema, :version, :major).to_i < 1
    end

  # deployment_type

    def blueprint_deployment_type
      @blueprint_deployment_type ||= blueprint[:software][:base][:deployment_type]
    end

  # websites

    def websites
      @websites ||= core_app.websites
    end

  # environment variables

    def environments
      @environments ||= container[:environments]
    end

    def environment_variables
      @environment_variables ||=
      environments.map do |variable| variable.without(:changed) end.group_by { |variable| variable[:owner_type] }.symbolize_keys.tap do |result|
        result[:service_consumers] = grouped_service_consumer_environment_variables_for(result)
      end.without(:service_consumer)
    end

    def grouped_service_consumer_environment_variables_for(ungrouped_variables)
      return {} unless ungrouped_variables[:service_consumer]
      ungrouped_variables[:service_consumer].group_by { |variable| variable[:owner_path].split(':').first }
    end

  # memory

    def memory
      @memory ||= container[:memory]
    end

    def minimum_memory
      @minimum_memory ||= blueprint[:software][:base][:memory][:required]
    end

    def recommended_memory
      @recommended_memory ||= blueprint[:software][:base][:memory][:recommended]
    end

  # network

    def blueprint_http_protocol
      @network_http_protocol ||= blueprint[:software][:base][:http_protocol]
    end

    def network_http_protocol
      @network_http_protocol ||= container[:protocol]
    end

    def network_host_name
      @network_host_name ||= container[:hostname]
    end

    def network_domain
      @network_domain ||= container[:domain_name]
    end

  # first_run

    def first_run_url
      @first_run_url ||= resolved_first_run_url
    end

    def resolved_first_run_url
      @resolved_first_run_url ||= core_app.resolve_string(blueprint[:software][:base][:first_run_url]) if blueprint[:software][:base][:first_run_url].present?
    end

  # services

    def persistent_services
      @persistent_services ||= core_app.persistent_services.sort_by{ |service| service[:container_name] }
    end

    def non_persistent_services
      @non_persistent_services ||= core_app.non_persistent_services.sort_by{ |service| service[:container_name] }
    end

    def available_services
      @available_services ||= core_app.available_services
    end

    def available_persistent_services
      @available_persistent_services ||= ( available_services[:persistent] || [] ).sort_by{ |service| service[:service_container] }
    end

    def available_non_persistent_services
      @available_non_persistent_services ||= ( available_services[:non_persistent] || [] ).sort_by{ |service| service[:service_container] }
    end

  # actions

    def actionators
      @actionators ||= core_app.actionators
    end

    def actionator_for(actionator_name)
      core_app.actionator_for(actionator_name)
    end

  end
end
