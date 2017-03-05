module Navbar
  module NavbarUsersHelper

    def navbar_user_menu_link
      # content_tag(:button, title: "Manage #{current_user.username}",
      #   class: 'btn_navbar', type: 'button',
      #   'data-toggle': :modal, 'data-target': "#user_menu_modal") do
      #     icon 'fa-user'
      # end

      button_to user_modals_menu_path,
        title: 'User menu',
        form_class: 'display_inline', method: :get, remote: true,
        class: 'btn_navbar show_wait_for_system_response_spinner' do
          icon 'fa-user'
        end
    end

    # def navbar_user_sign_in_link
    #   button_to new_user_session_path,
    #     title: 'Sign in',
    #     form_class: 'display_inline', method: :get,
    #     class: 'btn_navbar show_wait_for_system_response_spinner' do
    #       icon 'fa-sign-in'
    #     end
    # end

    def navbar_user_sign_in_modal_link
      button_to user_modals_sign_in_path,
        title: 'Sign in', id: 'user_sign_in_modal_link',
        form_class: 'display_inline', method: :get, remote: true,
        class: 'btn_navbar show_wait_for_system_response_spinner' do
          icon 'fa-sign-in'
        end
    end


    # def navbar_user_sign_in_link
		# 	link_to icon('fa-sign-in'),
		# 		new_user_session_path,
    #     title: 'Sign in',
    #     class: 'btn_navbar show_wait_for_system_response_spinner'
    # end

    def navbar_user_sign_out_link
      button_to destroy_user_session_path,
        title: 'Sign out',
        form_class: 'display_inline', method: :delete,
        class: 'btn_navbar show_wait_for_system_response_spinner' do
          icon 'fa-sign-out'
        end
    end

    # def navbar_user_sign_out_link
  	# 	link_to icon('fa-sign-out'),
  	# 		destroy_user_session_path,
    #     title: 'Sign out',
    #     class: 'btn_navbar show_wait_for_system_response_spinner',
  	# 		method: :delete
    # end

  end
end
