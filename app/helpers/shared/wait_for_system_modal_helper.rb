module Shared
  module WaitForSystemModalHelper

    def wait_for_local_system_modal(engines_system, opts)
      modal(header: {text: 'Waiting for application server', icon: 'fa-clock-o'}, id: 'wait_for_local_system_modal', header_close: false) do
        content_tag(:div, id: 'wait_for_system_progress', class: 'text-center') do
          content_tag(:div, icon_text(opts[:icon], opts[:message]))
        end
      end
    end

  end
end
