class EnginesSystem
  module CoreResources
    class Timezone

      include ActiveModel::Model

      attr_accessor  :engines_system
      attr_writer :timezone

      def timezone
        @timezone ||= core_system.timezone
      end

      def new_record?
        false
      end

      def update_system
        core_system.set_timezone @timezone
      end

      def core_system
        engines_system.core_system
      end


    end
  end
end
