module EnginesSystems
  class SignInsController < ApplicationController

    before_action :set_engines_system

    def new
      @sign_in = @engines_system.build_sign_in
    end

    def create
      @sign_in = @engines_system.build_sign_in(strong_params)
      if @sign_in.authenticate
        render js: 'location.reload();'
      else
        flash.now[:alert] = 'Failed to authenticate connection.'
        render 'engines_systems/sign_ins/new'
      end
    # rescue EnginesSystemApiConnectionRefusedError
    #   render 'clouds/systems/show'
    end

    private

    def strong_params
      params.require(:engines_system_core_resources_sign_in).permit(:password)
    end

  end
end
