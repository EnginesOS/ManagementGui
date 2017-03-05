module Systems
  module ControlPanelsHelper

    # def report_environment_variables(environment_variable_values)
    #   content_tag(:p) do
    #     environment_variable_values.map{|environment_variable| data_list_text environment_variable[:name].to_s, environment_variable[:value] }.join.html_safe +
    #     ('None' if environment_variable_values.empty?)
    #   end
    # end

    # def report_stats(stats)
    #   "State - #{stats.state}<br>
    #   Processes - #{stats.proc_cnt}<br>
    #   Stopped - #{time_ago stats.stopped_ts} (#{format_time stats.stopped_ts})<br>
    #   Started - #{time_ago stats.started_ts} (#{format_time stats.started_ts})<br>
    #   Virtual memory - #{stats.VSSMemory}<br>
    #   Resident memory - #{stats.RSSMemory}<br>
    #   CPU uptime - #{stats.cpuTime} seconds".
    #     html_safe if stats
    # end
    #
    # def report_volumes(volumes_hash)
    #   content_tag(:label, 'Volumes') +
    #   content_tag(:p) do
    #     volumes_hash.map do |volume|
    #       data_list_text volume[:name].to_s, report_volume_detail(volume)
    #     end.join.html_safe +
    #     ('None' if volumes.empty?)
    #   end
    # end
    #
    # def report_volume_detail(volume)
    #   "Remote path - #{volume[:remote_path]}<br>
    #   Local path - #{volume[:local_path]}<br>
    #   Mapping permissions - #{volume[:mapping_permissions]}<br>
    #   Volume permissions - #{volume[:volume_permissions]}<br>
    #   Service type - #{volume[:service_type]}".
    #     html_safe
    # end

  end
end
