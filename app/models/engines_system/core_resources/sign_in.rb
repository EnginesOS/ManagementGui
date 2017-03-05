class EnginesSystem
  module CoreResources
    class SignIn

      include ActiveModel::Model

      attr_accessor :password, :engines_system

      validates :password, presence: true

      def authenticate
        valid? && update_token
      end

      def token
        @token ||= engines_system.core_system.authenticate(password)
      end

      def update_token
        token && engines_system.update(token: token)
      end

    end
  end
end
