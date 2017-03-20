module EnginesSystems
  class DomainsController < ApplicationController

    before_action :set_engines_system

    def index
    end

    def new
      @domain = @engines_system.build_domain
    end

    def create
      @domain =  @engines_system.build_domain(strong_params)
      if @domain.add_to_system
        flash.now[:notice] = 'Successfully added domain.'
        render 'index'
      else
        render 'new'
      end
    end

    def edit
      @domain =  @engines_system.build_domain(strong_params)
    end

    def update
      @domain =  @engines_system.build_domain(strong_params)
      if @domain.update_system
        flash.now[:notice] = 'Successfully updated domain.'
        render 'index'
      else
        render 'edit'
      end
    end

    def destroy
      @domain =  @engines_system.build_domain(strong_params)
      if @domain.remove_from_system
        flash.now[:notice] = 'Successfully deleted domain.'
        render 'index'
      else
        render 'edit'
      end
    end

    private

    def strong_params
      params.require(:engines_system_core_resources_domain).permit(:domain_name, :internal_only, :self_hosted)
    end

  end
end
