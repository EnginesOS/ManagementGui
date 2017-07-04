module Navbar
  module NavbarCloudsHelper

    def cloud_menu_link(cloud)
      button_to cloud_menu_path(cloud_id: cloud.id),
        class: 'btn_navbar',
        form_class: 'display_inline', method: :get, remote: true,
        title: "#{cloud.label} menu" do
          icon 'fa-cloud'
        end
    end

    def navbar_cloud_link(cloud)
      button_to cloud_path, params: {cloud_id: cloud.id},
        title: "Administer #{cloud.label}",
        form_class: 'display_inline', method: :get,
        class: 'btn_navbar show_waiting_spinner' do
          icon 'fa-cog'
        end
    end

    def cloud_navbar_portal_link(cloud)
      button_to cloud_portal_path, params: {cloud_id: cloud.id},
        title: "#{cloud.label} portal",
        form_class: 'display_inline', method: :get,
        class: 'btn_navbar show_waiting_spinner' do
          icon 'fa-th'
        end
    end

    def navbar_user_portal_link
      button_to user_profile_portal_path,
        title: "User portal",
        form_class: 'display_inline', method: :get,
        class: 'btn_navbar show_waiting_spinner' do
          icon 'fa-home'
        end
    end


  end
end
