module EnginesSystemCore
  class CoreSystem
    module InstallApps

      def build_app(params)
        post 'containers/engines/build', params, parse: :boolean
      end

      def current_build_params
        get 'engine_builder/params', {}, parse: :json
      end

      def last_build_params
        get 'engine_builder/last_build/params', {}, parse: :json
      end

      def last_build_log
        get 'engine_builder/last_build/log', {}, parse: :string
      end

    end
  end
end
