module EnginesSystemCore
  class CoreSystem
    module Certificates

      def certificate_domain_names
        get 'system/certs/', expect: :json
      end

      def certificate_file(domain_name)
        get "system/certs/#{domain_name}", expect: :file
      end

      def save_domain_certificate(domain_name, certificate, key, password=nil)
        post 'system/certs/', params: {domain_name: domain_name, certificate: certificate, key: key, password: password}, expect: :boolean
      end

      def save_default_certificate(certificate, key, password=nil)
        post 'system/certs/default', params: {certificate: certificate, key: key, password: password}, expect: :boolean
      end

      def system_ca
        get "system/certs/system_ca", expect: :file
      end

    end
  end
end
