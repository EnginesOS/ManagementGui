module Navbar
  module UserProfileNavbarHelper

    def user_profile_navbar
      content_tag :nav, class: 'navbar navbar-default navbar-static-top' do
        content_tag :div, class: 'container-fluid' do
          content_tag(:div, class: 'navbar_section navbar-header') do
            navbar_brand(
              image_url: '/images/engines_logo.png',
              text: nil,
              link_url: nil )
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
