module Navbar
  module NavbarHelper

    def navbar
      if @error || @bug_report
        simple_navbar
      elsif controller_path == 'clouds/portals'
        cloud_admin_banner(@cloud) +
        cloud_portal_navbar(@cloud)
      elsif controller_path == 'user_profiles/portals'
        user_profile_portal_navbar
      elsif controller_path == 'user_profiles/user_profiles'
        user_profile_navbar
      elsif devise_controller? && !current_user
        simple_navbar
      elsif controller_name == 'installation_report_popups'
        ''.html_safe
      else
        cloud_admin_banner(@cloud) +
        cloud_navbar(@cloud)
      end
      #  +
      # if current_user
      #   user_menu_modal
      # else
      #   ''.html_safe # user_sign_in_modal
      # end
    end

    def navbar_left_links
      ''.html_safe
    end

    def navbar_right_links
      if current_user
        if controller_path == 'clouds/portals'
          navbar_user_portal_link +
          navbar_cloud_link(@cloud)
        else
          ''.html_safe
        end +
        if controller_path == 'clouds/clouds'
          cloud_menu_link(@cloud) +
          cloud_navbar_portal_link(@cloud)
        else
          ''.html_safe
        end +
        navbar_user_menu_link +
        navbar_user_sign_out_link
      else
        navbar_user_sign_in_modal_link
      end
    end

  end
end
