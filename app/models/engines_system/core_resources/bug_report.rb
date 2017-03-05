class EnginesSystem
  module CoreResources
    class BugReport

      include ActiveModel::Model

      attr_accessor  :engines_system
      attr_writer :send_bug_reports

      def send_bug_reports
        @send_bug_reports ||= core_system.remote_exception_logging?
      end

      def new_record?
        false
      end

      def update_system
        if @send_bug_reports == '1'
          core_system.enable_remote_exception_logging
        else
          core_system.disable_remote_exception_logging
        end
      end


      def core_system
        engines_system.core_system
      end


    end
  end
end
