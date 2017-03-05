class EnginesSystem
  module CoreResources
    class Activity

      include ActiveModel::Model

      attr_accessor :engines_system

      def core_system
        @core_system ||= engines_system.core_system
      end

      def system_memory_statistics
        @system_memory_statistics ||=
        begin
          core_system.system_memory_statistics
        rescue => e
          Rails.logger.warn "Failed to get 'memory statistics' from Engines System API. #{e}"
          raise
        end
      end

      def container_memory_statistics
        @container_memory_statistics ||= core_system.container_memory_statistics
      end

      def cpu_statistics
        @cpu_statistics ||= core_system.cpu_statistics
      end

      def disk_statistics
        @disk_statistics ||= core_system.disk_statistics
      end

      def network_statistics
        @network_statistics ||= core_system.network_statistics
      end

      def engines_memory
        @apps_memory ||=
          container_memory_statistics[:containers][:applications].
          map do |app_name, data|
            memory = data[:current]/1048576
            memory = 0 if memory < 0
            [ "#{app_name} #{memory} MB", memory ]
          end.
          sort_by { |app_name, memory| memory }.to_h
      end

      def engines_memory_ranges
        @apps_memory_ranges ||= calculate_engines_memory_ranges
      end

      def calculate_engines_memory_ranges
        currents = []
        peaks = []
        allocations = []
        container_memory_statistics[:containers][:applications].
        sort_by { |app_name, data| app_name }.to_h.
        each do |app_name, data|
          current = data[:current]
          maximum = data[:maximum]
          limit = data[:limit]
          currents << [app_name, current.to_f/limit]
          peaks << [app_name, (maximum - current).to_f/limit]
          allocations << [app_name, (limit - maximum).to_f/limit]
        end
        [ {name: 'Allocated', data: allocations},
          {name: 'Peak', data: peaks},
          {name: 'Current', data: currents} ]
      end

      def services_memory
        @services_memory ||=
          container_memory_statistics[:containers][:services].
          map do |service_name, data|
            memory = data[:current]/1048576
            memory = 0 if memory < 0
            [ "#{service_name} #{memory} MB", memory ]
          end.
          sort_by { |service_name, memory| memory }.to_h
      end

      def services_memory_ranges
        @services_memory_ranges ||= calculate_services_memory_ranges
      end

      def calculate_services_memory_ranges
        currents = []
        peaks = []
        allocations = []
        container_memory_statistics[:containers][:services].
        sort_by { |service_name, data| service_name }.to_h.
        each do |service_name, data|
          current = data[:current]
          maximum = data[:maximum]
          limit = data[:limit]
          currents << [service_name, current.to_f/limit]
          peaks << [service_name, (maximum - current).to_f/limit]
          allocations << [service_name, (limit - maximum).to_f/limit]
        end
        [ {name: 'Allocated', data: allocations},
          {name: 'Peak', data: peaks},
          {name: 'Current', data: currents} ]
      end

      def containers_memory
        @containers_memory ||=
        ( containers = container_memory_statistics[:containers][:totals]
          applications = containers[:applications][:allocated].to_i/1048576
          services = containers[:services][:allocated].to_i/1048576
          { "Apps #{applications} MB" => applications,
            "Services #{services} MB" => services } )
      end

      def containers_memory_ranges
        @containers_memory_ranges ||= calculate_containers_memory_ranges
      end

      def calculate_containers_memory_ranges
        currents = []
        peaks = []
        allocations = []
        container_memory_statistics[:containers][:totals].
        each do |group_name, data|
          group_name = group_name == :applications ? 'Apps' : 'Services'
          current = data[:in_use]
          maximum = data[:peak_sum]
          limit = data[:allocated]
          currents << [group_name, current.to_f/limit]
          peaks << [group_name, (maximum - current).to_f/limit]
          allocations << [group_name, (limit - maximum).to_f/limit]
        end
        [ {name: 'Allocated', data: allocations},
          {name: 'Peak', data: peaks},
          {name: 'Current', data: currents} ]
      end

      def unaccounted_memory
        @unaccounted_memory ||= ( system_memory_statistics[:total].to_i -
                                  system_memory_statistics[:active].to_i -
                                  system_memory_statistics[:buffers].to_i -
                                  system_memory_statistics[:file_cache].to_i -
                                  system_memory_statistics[:free].to_i )/1024
      end

      def system_memory
        @system_memory ||= {
          "Active #{system_memory_statistics[:active].to_i/1024} MB" =>
            system_memory_statistics[:active].to_i/1024,
          "Buffers #{system_memory_statistics[:buffers].to_i/1024} MB" =>
            system_memory_statistics[:buffers].to_i/1024,
          "File cache #{system_memory_statistics[:file_cache].to_i/1024} MB" =>
            system_memory_statistics[:file_cache].to_i/1024,
          "Free #{system_memory_statistics[:free].to_i/1024} MB" =>
            system_memory_statistics[:free].to_i/1024,
          }.merge( if unaccounted_memory > 0
              {"Other #{unaccounted_memory} MB" => unaccounted_memory}
            else; {}; end )
      end

      def cpu_load

  p :cpu_statistics
  p cpu_statistics
  p :cpu_statistics


        @cpu_load ||= []

        # (
        #   cpus_lookup = {}
        #   cpu_statistics.cpus.each do |cpu|
        #     cpus_lookup[cpu.num] =
        #       { user: cpu.user,
        #         system: cpu.system,
        #         nice: cpu.nice,
        #         idle: cpu.idle }
        #   end
        #   [
        #     { name: 'User', data: cpus_lookup.map{|num, cpu| ["CPU #{num}", cpu[:user] ] } },
        #     { name: 'System', data: cpus_lookup.map{|num, cpu| ["CPU #{num}", cpu[:system] ] } },
        #     { name: 'Nice', data: cpus_lookup.map{|num, cpu| ["CPU #{num}", cpu[:nice] ] } },
        #     { name: 'Idle', data: cpus_lookup.map{|num, cpu| ["CPU #{num}", cpu[:idle] ] } },
        #   ] )
      end

      def cpu_queue
        @cpu_queue ||=
          { "One min #{cpu_statistics[:one]}" =>
              [cpu_statistics[:one]],
             "Five mins #{cpu_statistics[:five]}" =>
              [cpu_statistics[:five]],
             "Fifteen mins #{cpu_statistics[:fifteen]}" =>
              [cpu_statistics[:fifteen]] }
      end

      def disks
        @disks ||=
        [ { name: 'Free', data: disk_space_lookup.map{|label, space| [ label, space[:free] ] } },
          { name: 'Used', data: disk_space_lookup.map{|label, space| [ label, space[:used] ] } } ]
      end

      def disk_space_lookup
        @disk_space_lookup ||=
        {}.tap do |result|
          disk_statistics.each do |label, disk|
            disk_size = disk[:blocks].to_f / 2097152
            disk_free = disk[:available].to_f / 2097152
            disk_label = "#{label} #{disk[:type]} #{disk[:mount]} #{disk_size.to_i} GB"
            result[disk_label] = { free: disk_free/disk_size,
                                  used: (disk_size - disk_free)/disk_size }
          end
        end
      end

      def network
        @network ||=
        [ { name: 'In', data: network_activity_lookup.map{|label, network| [ label, network[:in] ] } },
          { name: 'Out', data: network_activity_lookup.map{|label, network| [ label, network[:out] ] } } ]
      end

      def network_activity_lookup
        @network_activity_lookup ||=
          {}.tap do |result|
            network_statistics.each do |network|
              result[network.first] = { in: network.last[:rx],
                                       out: network.last[:tx] }
            end
          end
      end

    end
  end
end
