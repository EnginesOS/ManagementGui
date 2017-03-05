class App
  module CoreResources
    class Network

      include ActiveModel::Model
      extend ApplicationRecord::CustomAttributeLabels

      attr_accessor :app, :host_name, :domain_name, :http_protocol, :current_fqdn

      validates :host_name, presence: true
      validate :fqdn_not_reserved

      custom_attribute_labels http_protocol: 'Protocol'

      def blueprint_http_protocol
        @blueprint_http_protocol ||= app.blueprint_http_protocol
      end

      def http_protocol
        @http_protocol ||= app.network_http_protocol
      end

      def host_name
        @host_name ||= app.network_host_name
      end

      def domain_name
        @domain_name ||= app.network_domain
      end

      def current_fqdn
        @current_fqdn ||= fqdn
      end

      def protocol_select_collection
        case blueprint_http_protocol.to_sym
        when :http_only
          [ [:http_only, 'HTTP only'] ]
        when :https_only
          [ [:https_only, 'HTTPS only'] ]
        else
          [ [:https_and_http, 'HTTPS and HTTP'],
            [:http_and_https, 'HTTP and HTTPS'],
            [:https_only, 'HTTPS only'],
            [:http_only, 'HTTP only'] ]
        end
      end

      def save_to_system
        app.core_app.set_network_properties(network_update_params)
      end

      def network_update_params
        { http_protocol: http_protocol,
          host_name: host_name,
          domain_name: domain_name }
      end

      def fqdn_not_reserved
        errors.add(:base, "FQDN '#{fqdn}' is already in use") if
                fqdn_changed? && fqdn_reserved?
      end

      def fqdn_changed?
        current_fqdn != fqdn
      end

      def fqdn_reserved?
        reserved_fqdns.include? "fqdn}"
      end

      def fqdn
        "#{host_name}.#{domain_name}"
      end

      def reserved_fqdns
        @reserved_fqdns ||= core_system.reserved_fqdns
      end

      def core_system
        @core_system ||= app.engines_system.core_system
      end

    end
  end
end
