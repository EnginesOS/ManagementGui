class EnginesSystem
  module CoreResources
    class Domain

      include ActiveModel::Model

      attr_accessor :domain_name, :self_hosted, :internal_only, :engines_system

      DOMAIN_NAME_REGEX = /\A(local|(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9])\z/

      validates :domain_name, presence: true, format: { with: DOMAIN_NAME_REGEX, message: "is not valid"}

      def to_s
        domain_name
      end

      def current_domain_params
        @current_domain_params ||= domain_name.present? ? engines_system.domain_for(domain_name) : {}
      end

      def self_hosted
        @self_hosted ||= current_domain_params[:self_hosted]
      end

      def internal_only
        @internal_only ||= current_domain_params[:internal_only]
      end

      def update_system
        valid? && core_system.update_domain(domain_params)
      end

      def add_to_system
        valid? && core_system.add_domain(domain_params)
      end

      def remove_from_system
        core_system.remove_domain domain_name
      end

      def domain_params
        { domain_name: domain_name,
          internal_only: internal_only == '1',
          self_hosted: self_hosted == '1' }
      end

      def core_system
        engines_system.core_system
      end

    end
  end
end
