class Service
  module CoreResources
    class Memory

      include ActiveModel::Model
      include ActiveModel::Validations

      attr_accessor :service, :memory, :minimum, :recommended

      validates :memory, presence: true
      validate :memory_meets_minimum

      def memory
        @memory ||= service.memory
      end

      def minimum
        @minimum ||= service.minimum_memory
      end

      def recommended
        @recommended ||= service.recommended_memory
      end

      def update_system
        service.core_service.set_runtime_properties(memory: memory)
      end

      def memory_meets_minimum
        errors.add(:memory, "must be at least #{@minimum}") if memory < minimum
      end

    end
  end
end
