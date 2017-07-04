module Systems
  module DetailsHelper

    def system_menu_system_details(engines_system)
      content_tag(:div, class: 'container_menu_header clearfix') do
        content_tag(:div, class: 'container_menu_header_icon') do
        end +
        content_tag(:div, class: 'container_menu_header_names') do
          content_tag(:div, class: 'container_menu_header_label') do
            engines_system.label
          end +
          content_tag(:div, class: 'container_menu_header_label_subtext') do
            content_tag(:div, engines_system.url) +
            content_tag(:div, ( icon_text('fa-map-marker', 'Local system') if engines_system.is_local_system? ) )
          end
        end +
        content_tag(:div, class: 'container_menu_header_detail pull_right_wide_media') do
          content_tag(:div, pluralize(engines_system.installed_apps.count, "app")) +
          content_tag(:div, pluralize(engines_system.installed_services.count, "service"))
        end
      end +
      content_tag(:div, class: 'clearfix') do
        edit_resource_link :system_properties, params: {engines_system_id: engines_system.id}, text: 'Edit', icon: 'fa-edit', title: "Edit #{engines_system.label} display properties", class: 'pull_right_wide_media'
      end
    end

  end
end
