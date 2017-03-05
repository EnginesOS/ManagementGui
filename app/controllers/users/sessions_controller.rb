module Users
  class SessionsController < Devise::SessionsController

    # Hide sign in and signed out flashes
    before_action :clear_unwanted_flash_messages, only: [:new]
    after_action :clear_all_flash_messages, only: [:create, :destroy]

    def new
      redirect_to root_path(sign_in: true)
      # self.resource = resource_class.new(sign_in_params)
      # clean_up_passwords(resource)
      # yield resource if block_given?
      # render 'show_modal_sign_in', layout: false
    end

    private

    def clear_all_flash_messages
      flash.clear
    end

    # Unwanted devise messages should really be done by providing empty localization strings, rather than this...
    def clear_unwanted_flash_messages
      if flash[:alert] == 'You need to sign in before continuing.' ||
          flash[:alert] == 'Your session expired. Please sign in again to continue.'
        flash.clear
      end
    end

  end
end
