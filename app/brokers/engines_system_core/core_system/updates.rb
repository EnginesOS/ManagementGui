module EnginesSystemCore
  class CoreSystem
    module Updates

      def update_engines
        get 'system/control/engines_system/update', {}, parse: :boolean
      end

      def update_base_os
        get 'system/control/base_os/update', {}, parse: :boolean
      end

    end
  end
end
