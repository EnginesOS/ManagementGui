class EnginesSystem
  module CoreResources
    class Shutdown

      include ActiveModel::Model

      attr_accessor :reason, :engines_system

      def new_record?
        true
      end

      def shutdown
        core_system.shutdown(reason: reason)
      end

      def core_system
        engines_system.core_system
      end

    end
  end
end
