module Exceptions
  module BacktracesHelper

    def exception_detail_show_link
      content_tag :button, title: 'Show excpetion backtrace details',
        class: 'pull_right_wide_media btn btn-lg btn_resource',
        type: 'button', 'data-toggle': :tab,
        'data-target': '#exception_detail_hide_tab' do
        icon_text 'fa-file-text-o', 'Show details'
      end
    end

    def exception_detail_hide_link
      content_tag :button, title: 'Hide excpetion backtrace details',
        class: 'pull_right_wide_media btn btn-lg btn_resource',
        type: 'button', 'data-toggle': :tab,
        'data-target': '#exception_detail_show_tab' do
        icon_text 'fa-file-text-o', 'Hide details'
      end
    end

  end
end
