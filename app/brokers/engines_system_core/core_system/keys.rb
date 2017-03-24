module EnginesSystemCore
  class CoreSystem
    module Keys

      def key_file
        get 'system/keys/user/engines', expect: :file
      end

      def save_key(key)
        post 'system/keys/user/engines', params: { public_key: key }, expect: :boolean
      end

      def generate_key
        get 'system/keys/user/engines/generate', expect: :string
      end

    end
  end
end
