module EnginesSystems
  class DefaultDomainsController < ApplicationController

    before_action :set_engines_system

    def edit
      @default_domain = @engines_system.build_default_domain
    end

    def update
      @default_domain = @engines_system.build_default_domain(strong_params)
      if @default_domain.update_system
        flash.now[:notice] = 'Successfully updated default domain.'
        render 'engines_systems/domains/index'
      else
        render 'edit'
      end
    end

    private

    def strong_params
      params.require(:engines_system_core_resources_default_domain).permit(:domain)
    end

  end
end
