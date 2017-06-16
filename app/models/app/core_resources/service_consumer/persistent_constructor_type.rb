class App
  module CoreResources
    module ServiceConsumer
      class PersistentConstructorType

        include ActiveModel::Model

        attr_accessor :app, :publisher_type_path, :create_type, :existing_service, :orphan_service

        def label
          @label ||= "#{service_definition[:title]} (#{service_definition[:service_container]})"
        end

        def description
          @description ||= service_definition[:description]
        end

        def service_container_name
          service_definition[:service_container]
        end

        def service_definition
          @service_definition ||=
            app.engines_system.core_system.
            service_definition_for( publisher_type_path )
        end

        def create_type_collection
          [ [:new, 'Create new'] ].tap do |collection|
            collection << [:existing, 'Share existing'] if existing_services_collection.any?
            collection << [:orphan, 'Adopt orphan'] if orphan_services_collection.any?
          end
        end

        def existing_services_collection
          @existing_services_collection ||=
          engines_system.persistent_service_connections_for(publisher_type_path).map do |service_consumer|
            [ "#{service_consumer[:parent_engine]}##{service_consumer[:service_handle]}",
            (service_consumer[:parent_engine] +
            ( service_consumer[:parent_engine] ==
                        service_consumer[:service_handle] ?
                        '' : " - (#{service_consumer[:service_handle]})" ) ) ]
          end
        end

        def orphan_services_collection
          @orphan_services_collection ||=
          engines_system.orphan_service_connections_for(publisher_type_path).map do |service_consumer|
            ["#{service_consumer[:parent_engine]}##{service_consumer[:service_handle]}",
            (service_consumer[:parent_engine] +
            ( service_consumer[:parent_engine] ==
                        service_consumer[:service_handle] ?
                        '' : " - (#{service_consumer[:service_handle]})" ) ) ]
          end
        end

        def build_share_constructor
          app.build_persistent_service_consumer_share_constructor(
           publisher_type_path: publisher_type_path,
           parent_engine: existing_service.split('#').first,
           service_handle: existing_service.split('#').last )
        end

        def build_orphan_constructor
          app.build_persistent_service_consumer_orphan_constructor(
           publisher_type_path: publisher_type_path,
           parent_engine: orphan_service.split('#').first,
           service_handle: orphan_service.split('#').last )
        end

        def build_constructor
          app.build_persistent_service_consumer_constructor(
           publisher_type_path: publisher_type_path )
        end

        def engines_system
          app.engines_system
        end

      end
    end
  end
end
