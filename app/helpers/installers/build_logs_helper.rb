module Installers
  module BuildLogsHelper

    def installer_build_log_show_link
      content_tag :button, title: 'Show install build log',
        class: 'pull_right_wide_media btn btn-lg btn_resource',
        type: 'button', 'data-toggle': :tab,
        'data-target': '#installer_build_log_tab' do
        icon_text 'fa-file-text-o', 'Show log'
      end
    end

    def installer_build_log_hide_link
      content_tag :button, title: 'Show install build log',
        class: 'pull_right_wide_media btn btn-lg btn_resource',
        type: 'button', 'data-toggle': :tab,
        'data-target': '#installer_build_log_show_tab' do
        icon_text 'fa-file-text-o', 'Hide log'
      end
    end


    #
    # def installer_build_log_modal(engines_system)
    #   modal(header: {text: "Install build log", icon: 'fa-file-text-o'},
    #     footer_close: true, large: true, id: "installer_build_log_modal") do
    #     content_tag :div, data:
    #       { behavior: :stream_build_log,
    #         build_log_url: installer_build_log_path(engines_system_id: engines_system.id) } do
    #       content_tag :pre, nil, id: 'installer_builder_log'
    #     end
    #   end
    # end

  end
end
