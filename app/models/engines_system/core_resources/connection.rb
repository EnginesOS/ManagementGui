class EnginesSystem
  module CoreResources
    class Connection

      include ActiveModel::Model

      attr_accessor :engines_system
      attr_writer :url

      validates :url, presence: true

      def url
        @url ||= engines_system.url
      end

      def update_system
        engines_system.update(url: url)
      end

    end
  end
end
