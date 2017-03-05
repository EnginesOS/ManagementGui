module Installs
  class RepositoriesController < ApplicationController

    before_action :set_engines_system

    def new
      @install_repository_params =
        {
          engines_system_id: @engines_system.id,
          library_id: params[:library_id],
          repository_url:  params[:repository_url],
          install_metadata:  params.require(:install_metadata).permit!.to_h,
        }
    end


  end
end
