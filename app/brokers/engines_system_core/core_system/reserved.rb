module EnginesSystemCore
  class CoreSystem
    module Reserved

      def reserved_container_names
        get 'system/reserved/engine_names', expect: :json
      end

      def reserved_fqdns
        get 'system/reserved/hostnames', expect: :json
      end

      def reserved_ports
        get 'system/reserved/ports', expect: :json
      end

    end
  end
end
