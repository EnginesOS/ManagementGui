module Portals
  module PageBodyHelper

    def portal_page_body(cloud_or_user_profile, body)
      content_tag :body, style: page_body_style(cloud_or_user_profile) do
        portal_page_body_content(cloud_or_user_profile, body)
      end
    end

    def portal_page_body_content(cloud_or_user_profile, body)
      content_tag :div, class: 'container portal' do
        content_tag(:div,
            class: ('portal-body text-center' if cloud_or_user_profile.portal_center_align ) ) do
              flash_messages +
              portal_header(cloud_or_user_profile) +
              content_tag(:div, body, class: 'row row-centered') +
              portal_footer(cloud_or_user_profile)
        end
      end
    end

    def portal_header(cloud_or_user_profile)
      if cloud_or_user_profile.portal_header.present?
        content_tag :div, class: 'row' do
      		content_tag :div, class: 'col-sm-12' do
            markdown_text cloud_or_user_profile.portal_header
          end
        end
      else
        ''.html_safe
      end
    end

    def portal_footer(cloud_or_user_profile)
      if cloud_or_user_profile.portal_footer.present?
        content_tag :div, class: 'row' do
      		content_tag :div, class: 'col-sm-12' do
            markdown_text cloud_or_user_profile.portal_footer
          end
        end
      else
        ''.html_safe
      end
    end

  end
end
