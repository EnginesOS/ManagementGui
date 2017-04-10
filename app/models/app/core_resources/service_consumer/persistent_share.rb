class App
  module CoreResources
    module ServiceConsumer
      class PersistentShare < Base

        def label
          @label ||= "#{service_definition[:title]} share (#{service_definition[:service_container]}-#{parent_engine}-#{service_handle})"
        end

        def save_to_system
          app.core_app.update_persistent_service_consumer_share(
            parent_engine: parent_engine,
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

        def field_values
          @field_values ||=
          app.core_app.persistent_services_for_publisher_type_path( publisher_type_path ).find do |service|
            service[:service_handle] == service_handle
          end[:variables]
        end

      end
    end
  end
end
