class App
  module CoreResources
    class Memory

      include ActiveModel::Model

      attr_accessor :app, :memory, :minimum, :recommended, :exception

      validates :memory, presence: true
      validate :memory_meets_minimum

      def memory
        @memory ||= app.memory
      end

      def minimum
        @minimum ||= app.minimum_memory
      end

      def recommended
        @recommended ||= app.recommended_memory
      end

      def update_system
        app.core_app.set_runtime_properties(memory: memory)
      rescue EnginesError => e
        @exception = e
        false
      end

      def memory_meets_minimum
        errors.add(:memory, "must be at least #{@minimum}") if memory.to_i < minimum.to_i
      end

    end
  end
end
