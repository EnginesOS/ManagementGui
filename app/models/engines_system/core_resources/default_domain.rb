class EnginesSystem
  module CoreResources
    class DefaultDomain

      include ActiveModel::Model

      attr_accessor :domain, :engines_system

      validates :domain, presence: true

      def domain
        @domain ||= engines_system.default_domain
      end

      def update_system
        valid? && engines_system.core_system.update_default_domain(default_domain_params)
      end

      def default_domain_params
        { default_domain: domain }
      end

    end
  end
end
