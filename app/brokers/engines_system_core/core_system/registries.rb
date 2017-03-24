module EnginesSystemCore
  class CoreSystem
    module Registries

      def registry_configurations
        get 'registry/configurations/', expect: :json
      end

      def registry_apps
        get 'registry/engines/', expect: :json
      end

      def registry_services
        get 'registry/services/', expect: :json
      end

      def registry_orphans
        get 'registry/orphans/', expect: :json
      end

      def registry_shares
        get 'registry/shares/', expect: :json
      end

    end
  end
end
