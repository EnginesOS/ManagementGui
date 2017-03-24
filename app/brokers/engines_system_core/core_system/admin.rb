module EnginesSystemCore
  class CoreSystem
    module Admin

      def update_password(params)
        post "system/control/engines_system/update/password", params: params, expect: :boolean
      # rescue
      #   false
      end

      def update_email(params)
        post "system/control/engines_system/update/email", params: params, expect: :boolean
      # rescue
      #   false
      end

    end
  end
end
