module EnginesSystemCore
  class CoreSystem
    module Reserved

      def reserved_container_names
        get 'system/reserved/engine_names', parse: :json
      end

      def reserved_fqdns
        get 'system/reserved/hostnames', parse: :json
      end

      def reserved_ports
        get 'system/reserved/ports', parse: :json
      end

    end
  end
end
