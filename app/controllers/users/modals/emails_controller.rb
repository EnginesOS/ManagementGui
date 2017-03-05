module Users
  module Modals
    class EmailsController < ApplicationController

      def edit
        @user = current_user
      end

      def update
        @user = current_user
        if @user.email == strong_params[:email]
          flash.now[:alert] = "Email address for #{@user.username} was not changed."
          render 'users/modals/menus/show'
        elsif @user.update_password(strong_params)
          flash.now[:notice] = "Email address for #{@user.username} was successfully updated."
          render 'users/modals/menus/show'
        else
          render 'edit'
        end
      end

      private

      def strong_params
        params.require(:user).permit(:email, :current_password)
      end

    end
  end
end
