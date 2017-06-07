module EnginesSystemCore
  class CoreSystem
    module Restarts

      def restart_engines
        get 'system/control/engines_system/restart', expect: :boolean
      end

      def restart_base_os
        get 'system/control/base_os/restart', expect: :boolean
      end

      def shutdown(params)
        post 'system/control/base_os/shutdown', params: params, expect: :boolean
      end

    end
  end
end
