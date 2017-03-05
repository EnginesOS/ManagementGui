module EnginesSystemCore
  class CoreSystem
    module DefaultSites

      def default_site
        get 'system/config/default_site', parse: :string
      end

      # params: :default_site
      def update_default_site(params)
        post 'system/config/default_site', params, parse: :boolean
      end

    end
  end
end
