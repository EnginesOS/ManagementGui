module Shared
  module WaitForSystemModalHelper

    def wait_for_system_modal(engines_system, opts)
      modal(header: {text: 'Waiting for system', icon: 'fa-clock-o'}, id: 'wait_for_system_modal', header_close: false) do
        content_tag(:div, id: 'wait_for_system_progress', class: 'text-center',
        data: { redirect_url: cloud_path(cloud_id: engines_system.cloud.id),
                initial_wait: 5000,
                poll_url: system_busy_path(engines_system_id: engines_system.id),
                poll_period: 5000 }) do
          content_tag(:div, icon_text(opts[:icon], opts[:message]))
        end
      end
    end

  end
end
