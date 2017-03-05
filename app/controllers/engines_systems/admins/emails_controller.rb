module EnginesSystems
  module Admins
    class EmailsController < ApplicationController

      before_action :set_engines_system

      def edit
        @email = @engines_system.build_email
      end

      def update
        @email = @engines_system.build_email(strong_params)
        if @email.update_system
          flash.now[:notice] = "Admin email for #{@engines_system.label} was successfully updated."
          render 'engines_systems/admins/show'
        else
          render 'edit'
        end
      end

      def strong_params
        params.require(:engines_system_core_resources_email).permit(:password, :email)
      end

    end
  end
end
