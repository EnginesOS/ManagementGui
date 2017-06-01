module Clouds
  class SystemsController < ApplicationController

    before_action :set_cloud, only: [:new, :create]
    before_action :set_engines_system, only: [:show, :destroy]

    rescue_from ActionView::Template::Error, with: :handle_engines_error

    def show
    end

    def new
      @engines_system = @cloud.engines_systems.build
    end

    def create
      @engines_system = @cloud.engines_systems.build(strong_params)
      if @engines_system.save
        redirect_to cloud_path(cloud_id: @engines_system.cloud.id)
      else
        render 'new'
      end
    end

    def destroy
      # @cloud = @engines_system.cloud
      if @engines_system.destroy
        redirect_to cloud_path(cloud_id: @engines_system.cloud.id)
      else
        render 'clouds/systems_menus/show'
      end
    end

    private

    def strong_params
      params.require(:engines_system).permit(:label, :url) #, :token)
    end

    def handle_engines_error(e)
      @e = e.cause
      raise @e unless action_name == 'show'
      case @e
      when EnginesError::ApiConnectionAuthenticationError
        render 'show_with_authentication_error'
      when EnginesError
        render 'show_with_error'
      else
        raise @e
      end
    end

  end
end
