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
        EnginesSystemViewUpdateJob.perform_now(engines_system)
      else
        flash.now[:alert] =
          "Failed to uninstall #{ @uninstall.app.name }."
        render '/apps/control_panels/show'
      end
    rescue EnginesError => e
      raise EnginesError.new "Failed to uninstall #{ @uninstall.app.name }.\n\n#{e}"
    end

    private

    def strong_params
      params.require(:app_core_resources_uninstall).permit(:remove_data)
    end

 end
end
