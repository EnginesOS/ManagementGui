module EnginesSystemCore
  class CoreSystem
    module Updates

      def update_engines
        get 'system/control/engines_system/update', expect: :boolean
      end

      def update_base_os
        get 'system/control/base_os/update', expect: :boolean
      end

    end
  end
end
