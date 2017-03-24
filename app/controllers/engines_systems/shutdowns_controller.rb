module EnginesSystems
  class ShutdownsController < ApplicationController

    before_action :set_engines_system

    def new
      @shutdown = @engines_system.build_shutdown
    end

    def create
      @shutdown = @engines_system.build_shutdown(strong_params)
      if @shutdown.shutdown
        render
      else
        flash.now[:alert] = 'Failed to shutdown system.'
        render 'engines_systems/control_panels/show'
      end
    end

    private

    def strong_params
      params.require(:engines_system_core_resources_shutdown).permit(:reason)
    end

  end
end
