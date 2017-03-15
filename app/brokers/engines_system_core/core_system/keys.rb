module EnginesSystemCore
  class CoreSystem
    module Keys

      def key_file
        get 'system/keys/user/engines'
      end

      def save_key(key)
        post 'system/keys/user/engines', { public_key: key }, parse: :boolean
      end

      def generate_key
        get 'system/keys/user/engines/generate', {}, parse: :string
      end

    end
  end
end
