class App
  module CoreResources
    module ServiceConsumer
      class PersistentImport

        include ActiveModel::Model

        attr_accessor :app, :publisher_type_path, :service_handle, :data_file, :write

        validates :data_file, presence: true

        def label
          @label ||= "#{service_definition[:title]} (#{service_definition[:service_container]})"
        end

        def service_definition
          @service_definition ||=
            app.engines_system.core_system.
            service_definition_for( publisher_type_path )
        end

        def save_to_system
          app.core_app.persistent_service_consumer_import(
            publisher_type_path: publisher_type_path,
            service_handle: service_handle,
            data_file: uploaded_data_file,
            write: write )
        end

        def uploaded_data_file
          
          # data_file.tempfile.binmode
          File.new(data_file.path, 'rb') #{|io| io.read} #.force_encoding('iso-8859-1').encode('utf-8')
        end

      end
    end
  end
end
