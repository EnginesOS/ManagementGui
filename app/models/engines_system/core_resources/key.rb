class EnginesSystem
  module CoreResources
    class Key

      include ActiveModel::Model

      attr_accessor :engines_system, :key

      def file_from_system
        core_system.key_file
      end

      def uploaded_key_file
        key.rewind
        key.read
      end

      def update_system
        core_system.save_key(uploaded_key_file)
      end

      def generate_key
        core_system.generate_key
      end

      def core_system
        @core_system ||= engines_system.core_system
      end

    end
  end
end
