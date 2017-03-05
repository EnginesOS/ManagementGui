module EnginesSystemCore
  class CoreSystem
    module Restarts

      def restart_engines
        get 'system/control/engines_system/restart', parse: :boolean
        # true
      end

      def restart_base_os
        get 'system/control/base_os/restart', parse: :boolean
        # true
      end

      def shutdown(opts)
        post 'system/control/base_os/shutdown', params: opts
        # true
      end

    end
  end
end
