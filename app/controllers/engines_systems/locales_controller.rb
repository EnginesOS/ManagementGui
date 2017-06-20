module EnginesSystems
  class LocalesController < ApplicationController

    before_action :set_engines_system

    def edit
      @locale = @engines_system.build_locale
    end

    def update
      @locale = @engines_system.build_locale(strong_params)
      if @locale.update_system
        flash.now[:notice] = 'Successfully updated locale settings.'
        render 'engines_systems/control_panels/show'
      else
        flash.now[:alert] = 'Failed to update locale settings.'
        render 'edit'
      end
    end

    private

    def strong_params
      params.require(:engines_system_core_resources_locale).permit(:language, :country)
    end

  end
end
