module EnginesSystemCore
  class CoreSystem
    module ContainerStates

      def engine_states
        get 'containers/engines/state', expect: :json
      end

      def service_states
        get 'containers/services/state', expect: :json
      end

    end
  end
end
