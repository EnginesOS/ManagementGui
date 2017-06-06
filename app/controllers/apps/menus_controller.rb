module Apps
  class MenusController < ApplicationController

    before_action :set_app

    def show
      EnginesSystemViewUpdateJob.perform_later(@app.engines_system)
      if @app.engines_system.building? && @app.engines_system.current_build_app_name == @app.name
        redirect_to install_build_path(engines_system_id: @app.engines_system.id)
      else
        render
      end
    end

  end
end
