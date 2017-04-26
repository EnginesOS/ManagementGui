module EnginesSystemCore
  class CoreSystem
    module Versions

      def engines_version
        get 'system/version/system', expect: :plain_text
      end

      def base_system_version
        get 'system/version/base_os', expect: :json
      end

    end
  end
end
