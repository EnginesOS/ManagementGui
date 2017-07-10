class EnginesSystem
  module CoreResources
    class Activity

      include ActiveModel::Model

      attr_accessor :engines_system

      def colors(number_of_colors)
        colors = [
          '#F0AD4E',  # orange
          '#3071A9',  # blue
          '#89bf06',  # green
          '#8A6EAF',  # purple
          '#EFDA43',  # yellow
          '#EE3434',  # red
          '#999999',  # grey
          "#A630AC", "#3650A0", "#9F1D6D", "#80C837", "#1C167A", "#A012AA",
          "#DSES9F6E", "#C11C17", "#60B6CA", "#3EE61A", "#DE5003", "#4CA82B",
          "#EFCE10", "#E27A1D", "#7F91C3", "#434187", "#228B22", "#502E72", #loads of other colors for the skinny slices
          "#575597", "#3B256D", "#A63570", "#E6AA19", "#A670B8", "#93BDE7",
          "#6F6DA7", "#A6358C", "#A2395B"
        ]
        if number_of_colors <= colors.count
          colors.first(number_of_colors)
        else
          ( number_of_colors - colors.count ).times do
            colors << "#%06x" % (rand * 0xffffff)
          end
          colors
        end
      end

      def app_count
        @app_count ||= apps_memory[:datasets].first[:data].count
      end

      def services_count
        @services_count ||= services_memory[:datasets].first[:data].count
      end

      def core_system
        @core_system ||= engines_system.core_system
      end

      def system_memory_statistics
        @system_memory_statistics ||=
        begin
          core_system.system_memory_statistics
        rescue => e
          Rails.logger.debug "Failed to get 'memory statistics' from Engines System API. #{e}"
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

      def apps_memory
        @apps_memory ||= calculate_memory_for(:applications)
      end

      def services_memory
        @services_memory ||= calculate_memory_for(:services)
      end

      def calculate_memory_for(engine_type)
        labels = []
        data = []
        container_memory_statistics[:containers][engine_type].
        sort_by do |app_name, app_data|
          app_data[:current] * -1
        end.each do |app_name, app_data|
          memory = app_data[:current]/1048576
          memory = 0 if memory < 0
          labels << "#{app_name} #{memory} MB"
          data << memory
        end
        if data.length > 17
          labels = labels[0..16] << "#{labels[17..-1].count} #{"other".pluralize(labels[17..-1].count)} #{data[17..-1].sum} MB"
          data = data[0..16] << data[17..-1].sum
        end

        { labels: labels, datasets: [ { data: data, backgroundColor: colors(data.length) }] }
      end

      def apps_memory_ranges
        @apps_memory_ranges ||= calculate_memory_ranges_for(:applications)
      end

      def services_memory_ranges
        @services_memory_ranges ||= calculate_memory_ranges_for(:services)
      end

      def calculate_memory_ranges_for(engine_type)
        app_names = []
        currents = []
        peaks = []
        headrooms = []
        limits = []
        container_memory_statistics[:containers][engine_type].
        sort_by { |app_name, data| app_name }.to_h.
        each do |app_name, data|
          current = data[:current]
          maximum = data[:maximum]
          limit = data[:limit]
          limits << limit/1048576
          app_names << "#{app_name} #{limit/1048576}MB"
          currents << current.to_f/limit
          peaks << (maximum - current).to_f/limit
          headrooms << (limit - maximum).to_f/limit
        end
        {
          labels: app_names,
          memoryLimits: limits,
          datasets:
            [ {label: 'Current', data: currents, backgroundColor: '#3071A9' },
              {label: 'Peak', data: peaks, backgroundColor: '#F0AD4E' },
              {label: 'Allocated', data: headrooms, backgroundColor: '#89bf06' } ]
        }
      end

      def containers_memory
        @containers_memory ||= calculate_containers_memory
      end

      def calculate_containers_memory
        containers = container_memory_statistics[:containers][:totals]
        applications = containers[:applications][:allocated].to_i/1048576
        services = containers[:services][:allocated].to_i/1048576
        {
          labels: [ "Apps #{applications} MB", "Services #{services} MB" ],
          datasets: [ { data: [ applications, services ], backgroundColor: colors(2) } ]
        }
      end

      def containers_memory_ranges
        @containers_memory_ranges ||= calculate_containers_memory_ranges
      end

      def calculate_containers_memory_ranges
        labels = []
        currents = []
        peaks = []
        headrooms = []
        limits = []
        container_memory_statistics[:containers][:totals].
        each do |group_name, data|
          label = group_name == :applications ? 'Apps' : 'Services'
          current = data[:in_use]
          maximum = data[:peak_sum]
          limit = data[:allocated]
          limits << limit/1048576
          labels << "#{label} #{limit/1048576}MB"
          currents << current.to_f/limit
          peaks << (maximum - current).to_f/limit
          headrooms << (limit - maximum).to_f/limit
        end
        {
          labels: labels,
          memoryLimits: limits,
          datasets:
            [ {label: 'Current', data: currents, backgroundColor: '#3071A9' },
              {label: 'Peak', data: peaks, backgroundColor: '#F0AD4E' },
              {label: 'Allocated', data: headrooms, backgroundColor: '#89bf06' } ]
        }
      end

      def system_memory
        @system_memory ||= calculate_system_memory
      end

      def calculate_system_memory
        total = system_memory_statistics[:total].to_i/1024
        active = system_memory_statistics[:active].to_i/1024
        buffers = system_memory_statistics[:buffers].to_i/1024
        file_cache = system_memory_statistics[:file_cache].to_i/1024
        free = system_memory_statistics[:free].to_i/1024
        other = total - active - buffers - file_cache - free
        labels =
          [ "Active #{active} MB",
            "Buffers #{buffers} MB",
            "File cache #{file_cache} MB",
            "Free #{free} MB",
            "Other #{other} MB" ]
        other = 0 if other < 0
        data = [active, buffers, file_cache, free, other]
        { labels: labels, datasets: [ { data: data, backgroundColor: colors(5) }] }
      end

      def cpu_load
        {} # TODO
      end

      def cpu_queue
          {
            labels: [ "One min #{cpu_statistics[:one]}",
                      "Five mins #{cpu_statistics[:five]}",
                      "Fifteen mins #{cpu_statistics[:fifteen]}" ],
            datasets:
              [ { data: [ cpu_statistics[:one], cpu_statistics[:five], cpu_statistics[:fifteen] ], backgroundColor: [ '#3071A9', '#F0AD4E', '#89bf06' ] } ]
          }
      end

      def disks_usage
        @disks_usage ||= calculate_disks_usage
      end

      def disks_count
        disk_space_lookup.count
      end

      def calculate_disks_usage
        labels = []
        data_free = []
        data_used = []
        data_totals = []
        disk_space_lookup.map do |label, space|
          labels << label
          data_totals << space[:total]
          data_free << space[:free]/space[:total]
          data_used << space[:used]/space[:total]
        end
        { labels: labels,
          diskSizes: data_totals,
          datasets: [ { label: 'Used', data: data_used, backgroundColor: '#F0AD4E' }, { label: 'Free', data: data_free, backgroundColor: '#3071A9' } ] }
      end

      def disk_space_lookup
        @disk_space_lookup ||=
        {}.tap do |result|
          disk_statistics.each do |label, disk|
            disk_size = disk[:blocks].to_f / 2097152
            disk_free = disk[:available].to_f / 2097152
            disk_label = "#{label} #{disk[:type]} #{disk[:mount]} #{disk_size.to_i} GB"
            result[disk_label] = { total: disk_size,
                                   free: disk_free,
                                   used: (disk_size - disk_free) }
          end
        end
      end

      def network_interfaces_count

        network_activity_lookup.count
      end

      def network_activity
        @network_activity ||= calculate_network_activity
      end

      def calculate_network_activity
        labels = []
        data_in = []
        data_out = []
        network_activity_lookup.map do |label, network|
          labels << label
          data_in << network[:in]
          data_out << network[:out]
        end
        { labels: labels, datasets: [ { label: 'In', data: data_in, backgroundColor: '#3071A9' }, { label: 'Out', data: data_out, backgroundColor: '#F0AD4E' } ] }
      end

      def network_activity_lookup
        @network_activity_lookup ||=
          {}.tap do |result|
            network_statistics.each do |network|
              result[network.first] = { in: network.last[:rx].to_i/1024/1024,
                                       out: network.last[:tx].to_i/1024/1024 }
            end
          end
      end

    end
  end
end
