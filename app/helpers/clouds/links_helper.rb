module Clouds
  module LinksHelper

    def up_to_cloud_menu_link(cloud)
      content_tag :div, class: 'clearfix' do
        resource_link :cloud_menu, params: {cloud_id: cloud.id},
          class: 'btn btn-lg btn_resource pull_right_wide_media',
          text: false, icon: 'fa-arrow-up ', title: "Return to #{cloud.label} menu"
      end
    end

    def cloud_portal_link(cloud)
      resource_link :cloud_portal, params: {cloud_id: cloud.id},
        title: "Close cloud administration for #{cloud.label} and return to cloud portal",
        form_class: 'display_inline', remote: false,
        icon: 'fa-th', text: 'Cloud portal'
    end

    def user_profile_clouds_menu_link
      resource_link :user_profile_clouds_menu,
        title: "Manage clouds",
        icon: 'fa-cloud', text: 'Clouds'
    end

    def cloud_selection_link(target_cloud, current_cloud)
      resource_link :cloud,
      params: {cloud_id: target_cloud.id},
      text: target_cloud.label,
      disabled: target_cloud == current_cloud,
      icon: ( target_cloud == current_cloud ? 'fa-caret-right' : 'fa-angle-right' ),
      remote: false, title: "Administer #{target_cloud.label}"
    end

    def return_to_cloud_link(cloud)
      resource_link :cloud, params: {cloud_id: cloud.id}, remote: false, class: 'btn-lg',
      text: false, icon: 'fa-arrow-up ', title: "Return to #{cloud.label} cloud"
    end

    def toggle_show_services_link(cloud)
      resource_link :cloud_toggle_show_services,
      params: {cloud_id: cloud.id},
      text: (cloud.show_services ? 'Hide services' : 'Show services'),
      icon: 'fa-compass',
      remote: false
    end

    def new_cloud_local_system_link(cloud)
      resource_link :cloud_system,
        url: cloud_system_path(cloud_id: cloud.id),
        method: :post,
        params: {
                  engines_system: {
                    label: 'Local system',
                    url: Rails.application.config.local_system_api_url
                  }
                },
        text: 'Connect local system',
        icon: 'fa-wifi',
        title: 'Connect local Engines system'
    end

    def new_cloud_system_link(cloud)
      resource_link :new_cloud_system,
        params: {cloud_id: cloud.id},
        text: 'Connect system',
        icon: 'fa-wifi',
        title: 'Connect an Engines system'
    end

    def delete_cloud_system_link(engines_system)
      destroy_resource_link :cloud_system,
      params: {engines_system_id: engines_system.id},
      text: "Remove #{engines_system.label}",
      title: "Remove #{engines_system.label}",
      confirm: {text: "Are you sure that you want to remove #{engines_system.label} from #{engines_system.cloud.label}?" }
    end

    def new_cloud_link
      resource_link :new_user_profile_cloud, text: 'New cloud',
      icon: {back: 'fa-cloud', front: 'fa-plus', front_inverse: true},
      title: 'New Engines cloud'
    end

    def delete_cloud_link(cloud)
      destroy_resource_link :user_profile_cloud,
      params: {cloud_id: cloud.id},
      text: "Remove #{cloud.label}",
      title: "Remove #{cloud.label}",
      confirm: {text: "Are you sure that you want to remove #{cloud.label}?" }
    end

    def cloud_libraries_link(cloud)
      resource_link :cloud_libraries,
      params: {cloud_id: cloud.id},
      text: 'Libraries', icon: 'fa-plus-square', title: 'Manage libraries'
    end

    def cloud_systems_menu_link(cloud)
      resource_link :cloud_systems_menu,
      params: {cloud_id: cloud.id},
      text: 'Systems', icon: 'fa-hdd-o', title: 'Manage Engines systems'
    end

    def cloud_selection_menu_link(cloud)
      resource_link :cloud_cloud_selection_menu,
      params: {cloud_id: cloud.id},
      text: 'Change cloud', icon: 'fa-caret-right', title: 'Cloud selection menu'
    end

  end
end
