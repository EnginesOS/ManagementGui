module Reports
  module ReportsHelper
#
    def report_collapse_data(label, data)
      id = "report_#{label.underscore.gsub(' ' , '_').gsub('.' , '_')}_collapse"
      content_tag :div, class: "tab-content" do
        content_tag(:div, class: "tab-pane active", id: "#{id}_collapsed_tab") do
          content_tag :div, class: "clearfix" do
            content_tag :button, title: "Show #{label}",
              class: 'btn btn-lg btn_resource',
              type: 'button', 'data-toggle': :tab,
              'data-target': "##{id}_show_tab" do
              icon_text 'fa-caret-right', label
            end
          end
        end +
        content_tag(:div, class: "tab-pane", id: "#{id}_show_tab") do
          content_tag(:div, class: "clearfix") do
            content_tag :button, title: "Show #{label}",
              class: 'btn btn-lg btn_resource',
              type: 'button', 'data-toggle': :tab,
              'data-target': "##{id}_collapsed_tab" do
              icon_text 'fa-caret-down', label
            end
          end +
          content_tag(:div, pretty_print(data))
        end
      end
    end

  end
end
