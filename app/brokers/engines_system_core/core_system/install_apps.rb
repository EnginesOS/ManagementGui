module EnginesSystemCore
  class CoreSystem
    module InstallApps

      def build_app(params)
        post 'containers/engines/build', params: params, expect: :boolean
      end

      def current_build_params
        get 'engine_builder/params', expect: :json
      end

      def last_build_params
        get 'engine_builder/last_build/params', expect: :json
      end

      def last_build_log
        get 'engine_builder/last_build/log', expect: :plain_text
      end

    end
  end
end
