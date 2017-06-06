module Installs
  class BuildCompletesController < ApplicationController

    before_action :set_engines_system
    before_action :set_app

    def show
      if @engines_system.building?
        flash.now[:notice] = "Comminucation with the system was interrupted so the build log has been reloaded."
        render 'still_building'
      else
        if @engines_system.build_failed?
          flash.now[:alert] = "The installation of #{params[:app_name]} failed."
          render 'build_failed'
        else
          flash.now[:success] = "The installation of #{params[:app_name]} was successful."
          render
        end
      end
    end

    private

    def set_app
      @app = @engines_system.apps.find_by(name: params[:app_name])
    end

  end
end
