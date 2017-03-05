module Navbar
  module UserProfilePortalNavbarHelper

    def user_profile_portal_navbar
      content_tag :nav,
      class: 'portal_navbar navbar navbar-default navbar-static-top' do
        content_tag :div, class: 'container-fluid' do
          content_tag(:div, class: 'navbar_section navbar-header') do
            navbar_brand(
              image_url: ( current_user.user_profile.icon.url(:small) if
                                  current_user.user_profile.icon.present? ),
              text: current_user.user_profile.label.present? ?
                current_user.user_profile.label : current_user.username,
              link_url: user_profile_portal_path )
          end +
          navbar_left_links +
          content_tag(:div,
          class: 'navbar_section pull_right_wide_media') do
            navbar_right_links
          end
        end
      end
    end

  end
end
