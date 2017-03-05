module Navbar
  module DefaultNavbarHelper

    def simple_navbar
      content_tag :nav, class: 'portal_navbar navbar navbar-default navbar-static-top' do
        content_tag :div, class: 'container-fluid' do
          content_tag(:div, class: 'navbar_section navbar-header') do
            navbar_brand(
              image_url: '/images/engines_logo.png',
              text: nil,
              link_url: '/' )
          end
        end
      end
    end

  end
end
