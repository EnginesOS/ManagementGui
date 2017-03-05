module Installs
  class BuildsController < ApplicationController

    before_action :set_engines_system
    before_action :set_app

    def show
      if @engines_system.building?
        render
      else
        flash.now[:alert] = "System is not installing an app."
        render 'engines_systems/menus/show'
      end
    end

    private

    def set_app
      @app = @engines_system.apps.find_by(name: @engines_system.current_build_app_name)
    end


  end
end
