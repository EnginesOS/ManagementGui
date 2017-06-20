module Installs
  module BuildLogsHelper

    def install_build_log_show_link
      content_tag :button, title: 'Show install build log',
        class: 'pull_right_wide_media btn btn-lg btn_resource',
        type: 'button', 'data-toggle': :tab,
        'data-target': '#install_build_log_tab' do
        icon_text 'fa-file-text-o', 'Show log'
      end
    end

    def install_build_log_hide_link
      content_tag :button, title: 'Show install build log',
        class: 'pull_right_wide_media btn btn-lg btn_resource',
        type: 'button', 'data-toggle': :tab,
        'data-target': '#install_build_log_show_tab' do
        icon_text 'fa-file-text-o', 'Hide log'
      end
    end

  end
end
