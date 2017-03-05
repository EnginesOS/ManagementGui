module EnginesSystemCore
  class CoreSystem
    module Versions

      def engines_version
        get 'system/version/system', parse: :string
      end

      def base_system_version
        get 'system/version/base_os', parse: :json
      end

    end
  end
end
