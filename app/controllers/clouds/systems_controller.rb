module Clouds
  class SystemsController < ApplicationController

    before_action :set_cloud, only: [:new, :create]
    before_action :set_engines_system, only: [:show, :destroy]

    def show
      render
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

  end
end
