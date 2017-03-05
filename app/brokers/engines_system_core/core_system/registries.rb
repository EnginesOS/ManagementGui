module EnginesSystemCore
  class CoreSystem
    module Registries

      def registry_configurations
        get 'registry/configurations/', parse: :json
      end

      def registry_apps
        get 'registry/engines/', parse: :json
      end

      def registry_services
        get 'registry/services/', parse: :json
      end

      def registry_orphans
        get 'registry/orphans/', parse: :json
      end

      def registry_shares
        get 'registry/shares/', parse: :json
      end

    end
  end
end
