module EnginesSystems
  class TimezonesController < ApplicationController

    before_action :set_engines_system

    def edit
      @timezone = @engines_system.build_timezone
    end

    def update
      @timezone = @engines_system.build_timezone(strong_params)
      if @timezone.update_system
        flash.now[:notice] = 'Successfully updated timezone settings.'
        render 'engines_systems/control_panels/show'
      else
        flash.now[:alert] = 'Failed to update timezone settings.'
        render 'edit'
      end
    end

    private

    def strong_params
      params.require(:engines_system_core_resources_timezone).permit(:timezone)
    end

  end
end
