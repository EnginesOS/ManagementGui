class EnginesSystem
  module CoreResources
    class Email

      include ActiveModel::Model

      attr_accessor :engines_system, :password
      attr_writer :email

      validates :password, presence: true
      validates :email, presence: true

      def update_system
        valid? && core_system.update_email(update_params)
      end

      def email
        @email ||= engines_system.core_system.admin_user[:email]
      end

      def update_params
        { password: password,
          email: email }
      end

      def core_system
        engines_system.core_system
      end

    end
  end
end
