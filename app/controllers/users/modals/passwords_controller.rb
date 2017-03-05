module Users
  module Modals
    class PasswordsController < ApplicationController

      def edit
        @user = current_user
      end

      def update
        @user = current_user
        if @user.update_password(strong_params)
          flash.now[:notice] = "Password for #{@user.username} was successfully updated. Please sign in with the new password."
          render 'update'
        else
          render 'edit'
        end
      end

      private

      def strong_params
        params.require(:user).permit(:password, :password_confirmation, :current_password)
      end

    end
  end
end
