module Navbar
  module NavbarUsersHelper

    def navbar_user_menu_link
      button_to user_modals_menu_path,
        title: 'User menu',
        form_class: 'display_inline', method: :get, remote: true,
        class: 'btn_navbar show_waiting_spinner' do
          icon 'fa-user'
        end
    end

    def navbar_user_sign_in_modal_link
      button_to user_modals_sign_in_path,
        title: 'Sign in', id: 'user_sign_in_modal_link',
        form_class: 'display_inline', method: :get, remote: true,
        class: 'btn_navbar show_waiting_spinner' do
          icon 'fa-sign-in'
        end
    end

    def navbar_user_sign_out_link
      button_to destroy_user_session_path,
        title: 'Sign out',
        form_class: 'display_inline', method: :delete,
        class: 'btn_navbar show_waiting_spinner' do
          icon 'fa-sign-out'
        end
    end

  end
end
