module EnginesSystemCore
  class CoreSystem
    module DomainNames

      def list_domains
        get 'system/domains/', {}, parse: :json
      end

      def default_domain
        get 'system/config/default_domain', {}, parse: :string
      end

      # params: :default_domain
      def update_default_domain(params)
        post 'system/config/default_domain', params, parse: :boolean
      end

      def load_domain(params)
        get "system/domains/#{params[:domain_name]}", {}, parse: :json
      end

      def update_domain(params)
        post "system/domains/#{params[:domain_name]}", params, parse: :boolean
      end

      def add_domain(params)
        post 'system/domains/domain_name', params, parse: :boolean
      end

      def remove_domain(params)
        delete "system/domains/#{params[:domain_name]}", parse: :boolean
      end

    end
  end
end
