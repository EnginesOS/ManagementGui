module UserProfiles
  module LinksHelper

    def user_sign_out_link
      button_to destroy_user_session_path,
        title: 'Sign out',
        class: 'btn btn-lg btn_resource show_waiting_spinner',
        method: :delete do
          icon_text 'fa-sign-out', 'Sign out'
        end
    end

    def user_profile_link
      resource_link :user_profile, remote: false,
        title: "#{current_user.username} user profile", icon: 'fa-info', text: 'Profile'
    end

    def user_profile_portal_link
      resource_link :user_profile_portal,
        title: "#{current_user.username} user portal",
        remote: false,
        icon: 'fa-home', text: 'User portal'
    end

    def up_to_user_menu_link
      content_tag :div, class: 'clearfix' do
        resource_link :user_modals_menu,
          class: 'btn btn-lg btn_resource pull_right_wide_media',
          text: false, icon: 'fa-arrow-up ', title: "Return to user menu"
      end
    end



    # def user_sign_out_link
		# 	button_to destroy_user_session_path,
    #     title: 'Sign out',
    #     class: 'btn btn-lg btn_resource show_waiting_spinner',
		# 		method: :delete do
    #       icon_text('fa-sign-out', 'Sign out')
    #     end
    # end



    # def user_profile_link
		# 	button_to user_profile_path,
    #     title: "User profile for #{current_user.username}",
    #     class: 'btn btn-lg btn_resource show_waiting_spinner' do
    #       icon_text('fa-info', 'Profile')
    #     end
    # end

  end
end
