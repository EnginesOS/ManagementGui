module EnginesSystemCore
  class CoreSystem
    module Certificates

      def certificate_domain_names
        get 'system/certs/', parse: :json
      end

      def certificate_file(domain_name)
        get "system/certs/#{domain_name}"
      end

      def save_domain_certificate(domain_name, certificate, key, password=nil)
        post 'system/certs/', params: {domain_name: domain_name, certificate: certificate, key: key, password: password}, parse: :boolean
      end

      def save_default_certificate(certificate, key, password=nil)
        post 'system/certs/default', params: {certificate: certificate, key: key, password: password}, parse: :boolean
      end

      def system_ca
        get "system/certs/system_ca"
      end

    end
  end
end
