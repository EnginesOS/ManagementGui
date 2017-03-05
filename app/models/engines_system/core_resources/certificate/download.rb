class EnginesSystem
  module CoreResources
    module Certificate
      class Download

        include ActiveModel::Model

        attr_accessor :engines_system, :domain_name

        def file_from_system
          core_system.certificate_file(domain_name)
        end

        def core_system
          @core_system ||= engines_system.core_system
        end

      end
    end
  end
end
