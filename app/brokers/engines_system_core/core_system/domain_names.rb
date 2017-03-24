module EnginesSystemCore
  class CoreSystem
    module DomainNames

      def list_domains
        get 'system/domains/', expect: :json
      end

      def default_domain
        get 'system/config/default_domain', expect: :string
      end

      # params: :default_domain
      def update_default_domain(params)
        post 'system/config/default_domain', params: params, expect: :boolean
      end

      def load_domain(params)
        get "system/domains/#{params[:domain_name]}", expect: :json
      end

      def update_domain(params)
        post "system/domains/#{params[:domain_name]}", params: params, expect: :boolean
      end

      def add_domain(params)
        post 'system/domains/domain_name', params: params, expect: :boolean
      end

      def remove_domain(domain_name)
        delete "system/domains/#{domain_name}", expect: :boolean
      end

    end
  end
end
