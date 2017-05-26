module EnginesSystemCore
  class CoreSystem
    module Updates

      def update_engines
        get 'system/control/engines_system/update', expect: :boolean
        # false
      end

      def update_base_os
        get 'system/control/base_os/update', expect: :boolean
        # true
      end

    end
  end
end
