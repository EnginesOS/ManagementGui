class App
  module CoreResources
    module ServiceConsumer
      class NonPersistentRemove

        include ActiveModel::Model

        attr_accessor :app, :publisher_type_path, :service_handle, :remove_data

        def label
          @label ||= "#{service_definition[:title]} (#{service_definition[:service_container]} #{service_handle})"
        end

        def remove_from_system
          @app.core_app.remove_non_persistent_service_consumer(
              publisher_type_path: publisher_type_path,
              service_handle: service_handle )
        end

        def service_definition
          @service_definition ||=
            app.engines_system.core_system.
            service_definition_for( publisher_type_path )
        end

      end
    end
  end
end
