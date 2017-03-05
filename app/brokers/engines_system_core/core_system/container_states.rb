module EnginesSystemCore
  class CoreSystem
    module ContainerStates

      def engine_states
        get 'containers/engines/state', parse: :json
      end

      def service_states
        get 'containers/services/state', parse: :json
      end

    end
  end
end
