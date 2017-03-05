class App
  module CoreResources
    module ServiceConsumer
      class NonPersistentConstructor < Base

        def save_to_system
          app.core_app.create_non_persistent_service_consumer(
              publisher_type_path: publisher_type_path,
              variables: variable_values)
        end

        def form_params
          field_params_with_values.select do |field|
            field[:ask_at_build_time] == true || field[:immutable] != true
          end.map do |variable|
            field_attributes_for(variable)
          end
        end

        # def field_values
        #   @field_values ||=
        #   app.core_app.non_persistent_services_for_publisher_type_path( publisher_type_path ).find do |service|
        #     service[:service_handle] == service_handle
        #   end[:variables]
        # end

      end
    end
  end
end
