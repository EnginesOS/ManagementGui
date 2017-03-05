module Apps
  class InstallationReportPopupsController < ApplicationController

    before_action :set_app

    def show
      @cloud = @app.cloud
    end

  end
end
