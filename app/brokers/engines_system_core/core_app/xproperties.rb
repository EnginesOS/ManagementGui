module EnginesSystemCore
  class CoreApp
    module Properties

      def blueprint
        get system_api.get_app_blueprint(name), {}
      end

      def network_metrics
        get system_api.get_container_network_metrics(name), {}
      end

      def memory_statistics
        get system_api.get_app_memory_statistics(name), {}
      end

      def installation_report
        get system_api.get_app_build_report(name), ''
      end

      def attached_services
        get system_api.list_attached_services_for('ManagedEngine', name), []
      end

      def available_services
        get system_api.list_avail_services_for(api), {}
      end

    end
  end
end
