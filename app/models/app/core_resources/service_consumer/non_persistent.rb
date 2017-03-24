class App
  module CoreResources
    module ServiceConsumer
      class NonPersistent < Base

        def label
          @label ||= "#{service_definition[:title]} (#{service_definition[:service_container]} #{service_handle})"
        end

        def registration(action)
          params = {
            publisher_type_path: publisher_type_path,
            service_handle: service_handle
          }
          case action.to_sym
          when :register
            app.core_app.register_non_persistent_service_consumer params
          when :reregister
            app.core_app.reregister_non_persistent_service_consumer params
          when :deregister
            app.core_app.deregister_non_persistent_service_consumer params
          end
        end

        def save_to_system
          app.core_app.update_non_persistent_service_consumer(
              publisher_type_path: publisher_type_path,
              service_handle: service_handle,
              variables: variable_values)
        end

        def grouped_field_params_with_values
          @grouped_field_params_with_values ||=
          { immutable: field_params_with_values.select { |field| field[:immutable] == true },
            mutable: field_params_with_values.select { |field| field[:immutable] != true } }
        end

        def form_params
          grouped_field_params_with_values[:mutable].map do |variable|
            field_attributes_for(variable)
          end
        end

        def field_params_with_values
          consumer_params.map do |key, field|
            field[:value] = field_values[field[:name].to_sym]
            field
          end
        end

        def app_services
          app.core_app.non_persistent_services_for_publisher_type_path( publisher_type_path )
        end

      end
    end
  end
end
