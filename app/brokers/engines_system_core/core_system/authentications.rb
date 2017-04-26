module EnginesSystemCore
  class CoreSystem
    module Authentications

      def authenticate(password)
        get "system/login/admin/#{password}", expect: :plain_text
      end

    end
  end
end
