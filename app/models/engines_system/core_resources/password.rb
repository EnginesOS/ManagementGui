class EnginesSystem
  module CoreResources
    class Password

      include ActiveModel::Model

      attr_accessor :engines_system, :new_password, :new_password_confirmation, :current_password

      validates :current_password, presence: true
      validates :new_password, presence: true, confirmation: true
      # validate :new_password_confirmed

      def update_system
        valid? && core_system.update_password(update_params)
      end

      def update_params
        { user: :admin,
          current_password: @current_password,
          new_password: @new_password }
      end

      def core_system
        engines_system.core_system
      end

    end
  end
end
