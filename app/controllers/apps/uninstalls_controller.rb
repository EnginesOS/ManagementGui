module Apps
  class UninstallsController < ApplicationController

    before_action :set_app

    def new
      @uninstall = @app.build_uninstall
    end

    def create
      @uninstall = @app.build_uninstall(strong_params)
      if @uninstall.uninstall
        render 'create'
        engines_system = @app.engines_system
        @app.delete
        EnginesSystemViewUpdateJob.perform_later(engines_system)
      else
        if @uninstall.exception
          flash.now[@uninstall.exception.flash_message_params[:type]] =
         "Failed to uninstall #{ @uninstall.app.name }. The system reported the following error: #{
          @uninstall.exception.flash_message_params[:message] }"
        else
          flash.now[@uninstall.exception.flash_message_params[:type]] =
         "Failed to uninstall #{ @uninstall.app.name }."
        end
        render 'new'
      end
    end

    private

    def strong_params
      params.require(:app_core_resources_uninstall).permit(:remove_data)
    end

 end
end
