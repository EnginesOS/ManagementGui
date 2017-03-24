module EnginesSystemCore
  class CoreSystem
    module Authentications

      def authenticate(password)
        get "system/login/admin/#{password}", expect: :string
      end

    end
  end
end
