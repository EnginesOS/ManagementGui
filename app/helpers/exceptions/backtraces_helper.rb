module Exceptions
  module BacktracesHelper

    def exception_backtrace_show_link
      content_tag :button, title: 'Show excpetion backtrace details',
        class: 'pull_right_wide_media btn btn-lg btn_resource',
        type: 'button', 'data-toggle': :tab,
        'data-target': '#exception_backtrace_tab' do
        icon_text 'fa-file-text-o', 'Show details'
      end
    end

    def exception_backtrace_hide_link
      content_tag :button, title: 'Hide excpetion backtrace details',
        class: 'pull_right_wide_media btn btn-lg btn_resource',
        type: 'button', 'data-toggle': :tab,
        'data-target': '#exception_backtrace_show_tab' do
        icon_text 'fa-file-text-o', 'Hide details'
      end
    end


    #
    # def exception_backtrace_modal(engines_system)
    #   modal(header: {text: "Install build log", icon: 'fa-file-text-o'},
    #     footer_close: true, large: true, id: "exception_backtrace_modal") do
    #     content_tag :div, data:
    #       { behavior: :stream_build_log,
    #         build_log_url: installer_build_log_path(engines_system_id: engines_system.id) } do
    #       content_tag :pre, nil, id: 'installer_builder_log'
    #     end
    #   end
    # end

  end
end
