module EnginesSystemCore
  class CoreSystem
    module Statistics

      def container_memory_statistics
        get 'system/metrics/memory/statistics', expect: :json
      end

      def system_memory_statistics
        get 'system/metrics/memory', expect: :json
      end

      def cpu_statistics
        get 'system/metrics/load', expect: :json
      end

      def disk_statistics
        get 'system/metrics/disks', expect: :json
      end

      def network_statistics
        get 'system/metrics/network', expect: :json
      end

      # def base_os_data
      #   # SystemUtils.get_os_release_data
      # end
      #
      # def logs
      #   # 100.times.map{ |a| "log data."}.join("\n")
      # end

    end
  end
end
