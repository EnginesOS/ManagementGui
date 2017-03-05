module EnginesSystems
  class DefaultSitesController < ApplicationController

    before_action :set_engines_system

    def edit
      @default_site = @engines_system.build_default_site
    end

    def update
      @default_site = @engines_system.build_default_site(strong_params)
      if @default_site.update_system
        flash.now[:notice] = 'Successfully updated default site.'
        render 'engines_systems/control_panels/show'
      else
        render 'edit'
      end
    end

    private

    def strong_params
      params.require(:engines_system_core_resources_default_site).permit(:site)
    end

  end
end
