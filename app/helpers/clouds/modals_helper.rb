module Clouds
  module ModalsHelper

    def cloud_menu_modal(cloud)
      modal( header: {text: 'Cloud', icon: 'fa-cloud'},
      footer_close: true ) do
        cloud_menu_cloud_details(cloud) +
        content_tag(:hr) +
        cloud_portal_link(cloud) +
        toggle_show_services_link(cloud) +
        ( config.enable_multiple_libraries ? cloud_libraries_link(cloud) : ''.html_safe ) +
        ( config.enable_multiple_systems ? cloud_systems_menu_link(cloud) : ''.html_safe ) +
        ( config.enable_multiple_clouds ? cloud_selection_menu_link(cloud) : ''.html_safe )
      end
    end

    def cloud_selection_menu_modal(cloud)
      modal(header: {text: 'Cloud selection', icon: 'fa-cloud'},
      footer_close: true) do
        up_to_cloud_menu_link(cloud) +
        current_user.user_profile.clouds.map do |target_cloud|
          cloud_selection_link(target_cloud, cloud)
        end.join.html_safe
      end
    end

  end
end
