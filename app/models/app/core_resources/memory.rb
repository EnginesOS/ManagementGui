class App
  module CoreResources
    class Memory

      include ActiveModel::Model

      attr_accessor :app, :limit, :minimum, :recommended

      validates :limit, presence: true
      validate :limit_meets_minimum

      def limit
        @limit ||= app.memory_metrics[:limit].to_i/1024/1024
      end

      def minimum
        @minimum ||= app.minimum_memory
      end

      def recommended
        @recommended ||= app.recommended_memory
      end

      def update_system
        @app.core_app.set_runtime_properties(memory: limit)
      end

      def limit_meets_minimum
        errors.add(:limit, "must be at least #{@minimum}") if limit.to_i < minimum.to_i
      end

    end
  end
end
