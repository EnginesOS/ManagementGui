module EnginesSystemCore
  class CoreSystem
    module DefaultSites

      def default_site
        get 'system/config/default_site', expect: :string
      end

      # params: :default_site
      def update_default_site(params)
        post 'system/config/default_site', params: params, expect: :boolean
      end

    end
  end
end
