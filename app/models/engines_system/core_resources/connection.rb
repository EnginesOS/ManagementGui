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

      def update
        return true if engines_system.update(url: url)
        errors.add(:url, engines_system.errors[:url])
        false
      end

    end
  end
end
