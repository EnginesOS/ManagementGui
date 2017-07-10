module EnginesSystems
  module Admins
    class PasswordsController < ApplicationController

      before_action :set_engines_system

      def edit
        @password = @engines_system.build_password
      end

      def update
        @password = @engines_system.build_password(strong_params)
        if @password.update_system
          flash.now[:notice] = "Admin password for #{@engines_system.label} was successfully updated.\n\nYou will need to re-authenticate to connect to the system."
          render 'update'
        else
          render 'edit'
        end
      end

      def strong_params
        params.require(:engines_system_core_resources_password).permit(:new_password, :new_password_confirmation, :current_password)
      end

    end
  end
end
