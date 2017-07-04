class EnginesSystem
  module CoreResources
    module Certificate
      class Download

        include ActiveModel::Model

        attr_accessor :engines_system, :certificate_path

        def file_from_system
          core_system.certificate_file(certificate_path)
        end

        def core_system
          @core_system ||= engines_system.core_system
        end

      end
    end
  end
end
