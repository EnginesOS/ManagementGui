class App
  module CoreResources
    module ServiceConsumer
      class Persistent < Base

        def label
          @label ||= "#{service_definition[:title]} (#{service_definition[:service_container]} #{service_handle})"
        end

        def save_to_system
            app.core_app.update_persistent_service_consumer(
                publisher_type_path: publisher_type_path,
                service_handle: service_handle,
                variables: variable_values)
        end

        def field_params_with_values
          @field_params_with_values ||=
          consumer_params.map do |key, field|
            field[:value] = field_values[field[:name].to_sym]
            field
          end
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

        def app_services
          app.core_app.persistent_services_for_publisher_type_path( publisher_type_path )
        end

        def available_subservices
          app.core_app.available_subservices_for(publisher_type_path)[:non_persistent]
        end

        def subservice_consumer_constructors
          @subservice_consumer_constructors ||=
          available_subservices.map do |subservice|
            app.build_persistent_service_consumer_subservice_consumer_constructor(
              parent_service_handle: service_handle,
              parent_publisher_type_path: publisher_type_path,
              publisher_type_path: "#{subservice[:publisher_namespace]}/#{subservice[:type_path]}" )
          end
        end

        def subservice_consumers
          @subservice_consumers = []
        end



      end
    end
  end
end
