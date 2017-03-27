module EnginesSystems
  class ConnectionsController < ApplicationController

    before_action :set_engines_system

    def edit
      @connection =  @engines_system.build_connection
    end

    def update
      @connection =  @engines_system.build_connection(strong_params)
      if @connection.update
        flash.now[:notice] = 'Successfully updated connection.'
        redirect_to cloud_path(cloud_id: @engines_system.cloud.id)
      else
        render 'edit'
      end
    end

    private

    def strong_params
      params.require(:engines_system_core_resources_connection).permit(:url)
    end

  end
end
