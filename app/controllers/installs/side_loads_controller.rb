module Installs
  class SideLoadsController < ApplicationController

    before_action :set_engines_system

    def new
      @side_load = Install::SideLoad.new
    end

    def create
      @side_load = Install::SideLoad.new
      @side_load.assign_attributes strong_params
      if @side_load.valid?
        # redirect_to new_install_repository_path engines_system_id: @engines_system.id, install_repository: {repository_url: @side_load.repository_url}
        render
      else
        render 'new'
      end
    end

    private

    def strong_params
      params.require(:install_side_load).permit(:repository_url)
    end

  end
end
