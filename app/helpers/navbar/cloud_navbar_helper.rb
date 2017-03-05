module Navbar
  module CloudNavbarHelper

    def cloud_navbar(cloud)
      content_tag :nav, class: 'navbar navbar-default navbar-static-top' do
        content_tag :div, class: 'container-fluid' do
          content_tag(:div, class: 'navbar_section navbar-header') do
            navbar_brand(
              image_url: ( cloud.icon.url(:small) if cloud.icon.present? ),
              text: cloud.label,
              link_url: cloud_portal_path,
              link_params: { cloud_id: cloud.id } )
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
