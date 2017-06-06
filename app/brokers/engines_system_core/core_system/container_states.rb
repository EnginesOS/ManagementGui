module EnginesSystemCore
  class CoreSystem
    module ContainerStates

      def engine_statuses
        get 'containers/engines/status', expect: :json
      end

      def service_statuses
        get 'containers/services/status', expect: :json
        # raise EnginesError.new "wow"
      end

    end
  end
end
