module Users
  module SignInsHelper

    def user_sign_in_modal
      modal(header: {text: "Sign in", icon: 'fa-sign-in'},
        footer_close: false) do
          user_sign_in_modal_form +
          content_tag(:div, class: 'col-sm-12') do
            content_tag(:hr) +
            render("users/shared/links")
          end
      end
    end

    def user_sign_in_modal_form
      form_for(resource, as: resource_name, url: session_path(resource_name), user_sign_in_form: true) do |f|
        ( f.engines_field :username, horizontal: true, left: 4, width: 6  ) +
        ( f.engines_field :password, as: :password, horizontal: true, left: 4, width: 6 ) +
        ( f.engines_cancel_submit({ text: 'Sign in', icon: 'fa-sign-in' }) )
      end
    end

  end
end
