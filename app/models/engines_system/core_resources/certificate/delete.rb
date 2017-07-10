class EnginesSystem
  module CoreResources
    module Certificate
      class Delete

        include ActiveModel::Model

        attr_accessor :engines_system, :certificate_path

        def update_system
          core_system.delete_certificate(certificate_path)
        end

        def core_system
          @core_system ||= engines_system.core_system
        end

      end
    end
  end
end
