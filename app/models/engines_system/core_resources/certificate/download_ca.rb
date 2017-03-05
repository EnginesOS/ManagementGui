class EnginesSystem
  module CoreResources
    module Certificate
      class DownloadCa

        include ActiveModel::Model

        attr_accessor :engines_system

        def file_from_system
          core_system.system_ca
        end

        def core_system
          @core_system ||= engines_system.core_system
        end

      end
    end
  end
end
