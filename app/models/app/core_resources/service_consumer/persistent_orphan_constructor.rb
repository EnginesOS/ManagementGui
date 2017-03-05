class App
  module CoreResources
    module ServiceConsumer
      class PersistentOrphanConstructor < Base

        def save_to_system
          app.core_app.create_persistent_service_consumer_orphan(
              publisher_type_path: publisher_type_path,
              parent_engine: parent_engine,
              service_handle: service_handle,
              variables: variable_values)
        end

        def form_params
          field_params_with_values.select { |field| field[:immutable] != true }.map do |variable|
            field_attributes_for(variable)
          end
        end

      end
    end
  end
end
