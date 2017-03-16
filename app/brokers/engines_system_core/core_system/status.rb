module EnginesSystemCore
  class CoreSystem
    module Status

      def builder_status
        get 'engine_builder/status', expect: :json
      end

      def system_status
        get 'system/status', expect: :json
      end

      def system_update_status
        get 'system/status/update', expect: :json
      end

      def first_run_required?
        get 'system/status/first_run_required', expect: :boolean
      end

    end
  end
end
