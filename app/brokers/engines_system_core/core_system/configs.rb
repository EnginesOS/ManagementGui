module EnginesSystemCore
  class CoreSystem
    module Configs

      def remote_exception_logging?
        get 'system/config/remote_exception_logging', expect: :boolean
      end

      def enable_remote_exception_logging
        post 'system/config/remote_exception_logging/enable', expect: :boolean
      end

      def disable_remote_exception_logging
        post 'system/config/remote_exception_logging/disable', expect: :boolean
      end




    end
  end
end
