class App
  module CoreResources
    module ServiceConsumer
      class PersistentExport

        include ActiveModel::Model

        attr_accessor :app, :publisher_type_path, :service_handle

        def file
          # Base64.decode64(
            app.core_app.persistent_service_consumer_export(
              publisher_type_path: publisher_type_path,
              service_handle: service_handle)
              # )
        end

      end
    end
  end
end
