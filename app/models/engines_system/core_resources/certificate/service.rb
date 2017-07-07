class EnginesSystem
  module CoreResources
    module Certificate
      class Service

        include ActiveModel::Model

        attr_accessor :engines_system, :service_name, :cert_name

        def update_system
          core_system.update_service_certificate(service_name: service_name, cert_name: cert_name)
        end

        def cert_name_collection
          @cert_name_collection ||= core_system.certificates.map{ |cert| cert[:cert_name] }
        end

        def core_system
          @core_system ||= engines_system.core_system
        end

      end
    end
  end
end
