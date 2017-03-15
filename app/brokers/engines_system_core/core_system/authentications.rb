module EnginesSystemCore
  class CoreSystem
    module Authentications

      def authenticate(password)
        get "system/login/admin/#{password}", {}, parse: :string
      end

    end
  end
end
