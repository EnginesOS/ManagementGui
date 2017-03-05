module Apps
  class LogsController < ApplicationController

    before_action :set_app

    def show
      # render js: "alert('Does the API support system logs?');"
    end

  end
end
