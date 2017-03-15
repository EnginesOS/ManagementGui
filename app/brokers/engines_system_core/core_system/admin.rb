module EnginesSystemCore
  class CoreSystem
    module Admin

      def update_password(params)
        post "system/control/engines_system/password", params, parse: :boolean
      # rescue
      #   false
      end

      def update_email(params)
        post "system/user/update/email", params, parse: :boolean
      # rescue
      #   false
      end

    end
  end
end
