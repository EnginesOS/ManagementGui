module Clouds
  class ToggleShowServicesController < ApplicationController

    before_action :set_cloud

    def show
      @cloud.update(show_services: !@cloud.show_services)
      redirect_to cloud_path(cloud_id: @cloud.id)
    end

  end
end
