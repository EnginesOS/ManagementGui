module Navbar
  module CloudPortalNavbarHelper

    def cloud_portal_navbar(cloud)
      if current_user && current_user.user_profile.clouds.find(cloud.id)
        link_url = cloud_path
        link_params = { cloud_id: cloud.id }
      else
        link_url = ''
        link_params = {}
      end
      content_tag :nav, class: 'portal_navbar navbar navbar-default navbar-static-top' do
        content_tag :div, class: 'container-fluid' do
          content_tag(:div, class: 'navbar_section navbar-header') do
            navbar_brand(
              image_url: ( cloud.icon.url(:small) if cloud.icon.present? ),
              text: cloud.label,
              link_url: link_url,
              link_params: link_params )
          end +
          navbar_left_links +
          content_tag(:div, class: 'navbar_section pull_right_wide_media') do
            navbar_right_links
          end
        end
      end
    end

  end
end
