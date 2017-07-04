class Install
  class NewApp
    class ServiceConsumer

      include ActiveModel::Model

      attr_accessor :new_app, :type_path, :create_type, :existing_service, :orphan_service

      attr_writer :label, :description

      def create_type_collection
        [ [:new, 'Create new'] ].tap do |collection|
          collection << [:existing, 'Share existing'] if existing_services_collection.any?
          collection << [:orphan, 'Adopt orphan'] if orphan_services_collection.any?
        end
      end

      def existing_services_collection=(json)
        @existing_services_collection ||= JSON.parse(json)
      end

      def existing_services_collection
        @existing_services_collection ||=
        engines_system.persistent_service_connections_for(type_path).map do |service_consumer|
          [ "#{service_consumer[:parent_engine]}##{service_consumer[:service_handle]}",
          (service_consumer[:parent_engine] +
          ( service_consumer[:parent_engine] ==
                      service_consumer[:service_handle] ?
                      '' : " - (#{service_consumer[:service_handle]})" ) ) ]
        end
      end

      def orphan_services_collection=(json)
        @orphan_services_collection ||= JSON.parse(json)
      end

      def orphan_services_collection
        @orphan_services_collection ||=
        engines_system.orphan_service_connections_for(type_path).map do |service_consumer|
          ["#{service_consumer[:parent_engine]}##{service_consumer[:service_handle]}",
          (service_consumer[:parent_engine] +
          ( service_consumer[:parent_engine] ==
                      service_consumer[:service_handle] ?
                      '' : " - (#{service_consumer[:service_handle]})" ) ) ]
        end
      end

      def service_definition
        @service_definition ||=
        engines_system.service_definition_for(type_path)
      end

      def engines_system
        @engines_system ||= new_app.engines_system
      end

      def persistent?
        service_definition[:persistent]
      end

      def label
        @label ||= service_definition[:title]
      end

      def description
        @description ||= [ label, service_definition[:description] ].compact.join(' - ')
      end

      def selected_service_consumer
        if create_type.to_sym == :existing
          existing_service
        elsif create_type.to_sym == :orphan
          orphan_service
        else
          '#'
        end
      end

      def parent_app_for_selected
        selected_service_consumer.split('#').first
      end

      def service_handle_for_selected
        selected_service_consumer.split('#').last
      end

    end
  end
end
