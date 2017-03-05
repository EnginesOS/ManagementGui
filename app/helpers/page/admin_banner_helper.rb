module Page
  module AdminBannerHelper

    def cloud_admin_banner(cloud)
      if current_user && current_user.is_admin? &&
          cloud && cloud.admin_banner.present?
        content_tag :h1,
          class: 'admin_banner container-fluid row text-center',
          style: page_body_style(cloud) do
            cloud.admin_banner
          end
      else
        ''.html_safe
      end
    end

    # def cloud_admin_banner_style(cloud)
    #   page_body_style(cloud)
    # end

  end
end
