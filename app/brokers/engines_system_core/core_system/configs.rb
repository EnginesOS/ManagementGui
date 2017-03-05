module EnginesSystemCore
  class CoreSystem
    module Configs

      def remote_exception_logging?
        get 'system/config/remote_exception_logging', parse: :boolean
      end

      def enable_remote_exception_logging
        post 'system/config/remote_exception_logging/enable', parse: :boolean
      end

      def disable_remote_exception_logging
        post 'system/config/remote_exception_logging/disable', parse: :boolean
      end




    end
  end
end
