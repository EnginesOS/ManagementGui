class App
  module CoreResources
    module ServiceConsumer
      class PersistentSubserviceConstructor < Base

        attr_accessor :parent_service_handle, :parent_publisher_type_path

        def save_to_system
          app.core_app.create_persistent_service_consumer_subservice_consumer(
            service_name: parent_service_definition[:service_container],
            parent_service_handle: parent_service_handle,
            publisher_type_path: publisher_type_path,
            variables: variable_values )
        end

        def form_params
          field_params_with_values.select do |field|
            field[:ask_at_build_time] == true || field[:immutable] != true
          end.map do |variable|
            field_attributes_for(variable)
          end
        end

        def parent_service_definition
          @parent_service_definition ||=
            app.engines_system.core_system.
            service_definition_for( parent_publisher_type_path )
        end





      end
    end
  end
end
