module EnginesSystemCore
  class CoreSystem
    module Status

      def builder_status
        get 'engine_builder/status', parse: :json
      end

      def system_status
        get 'system/status', parse: :json
      end

      def system_update_status
        get 'system/status/update', parse: :json
      end

      def first_run_required?
        get 'system/status/first_run_required', parse: :boolean
      end

    end
  end
end
