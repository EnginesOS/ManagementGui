class EnginesSystem
  module CoreResources
    module Certificate
      class Delete

        include ActiveModel::Model

        attr_accessor :engines_system, :domain_name

        def update_system
          core_system.delete_certificate(domain_name)
        end

        def core_system
          @core_system ||= engines_system.core_system
        end

      end
    end
  end
end
