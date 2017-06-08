module UserProfiles
  module ModalsHelper

    def user_menu_modal
      modal(header: {text: current_user.username, icon: 'fa-user'},
      footer_close: true) do
        content_tag(:div, class: 'dl-horizontal') do
          data_list_text('Email', @user.email) +
          data_list_text('Sign in count', @user.sign_in_count) +
          data_list_text('Current sign in', "#{format_time @user.current_sign_in_at} (from #{@user.current_sign_in_ip})", title: time_ago(@user.current_sign_in_at)) +
          data_list_text('Last sign in', "#{format_time @user.last_sign_in_at} (from #{@user.last_sign_in_ip})", title: time_ago(@user.last_sign_in_at))
        end +
        content_tag(:hr) +
        user_profile_portal_link +
        user_profile_clouds_menu_link +
        resource_link(:edit_user_modals_password, text: 'Password', icon: 'fa-lock') +
        resource_link(:edit_user_modals_email, text: 'Email', icon: 'fa-envelope-o') +
        user_sign_out_link
      end
    end

    def user_clouds_menu_modal
      modal(header: {text: 'Clouds', icon: 'fa-cloud'},
      footer_close: true) do
        up_to_user_menu_link +
        new_cloud_link +
        if current_user.user_profile.clouds.present?
          content_tag(:hr) +
          delete_cloud_links
        else
          ''.html_safe
        end
      end
    end

    def delete_cloud_links
      current_user.user_profile.clouds.map do |cloud|
        delete_cloud_link(cloud)
      end.join.html_safe
    end

  end
end
