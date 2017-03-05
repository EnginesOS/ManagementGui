class EnginesSystem
  module CoreResources
    class DefaultSite

      include ActiveModel::Model

      attr_accessor :site, :engines_system

      validates :site, presence: true

      def site
        @site ||= engines_system.default_site
      end

      def update_system
        valid? && core_system.update_default_site(default_site_params)
      end

      def default_site_params
        { default_site: site }
      end

      def core_system
        engines_system.core_system
      end

    end
  end
end
