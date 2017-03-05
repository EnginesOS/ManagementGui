module Apps
  class FirstRunsController < ApplicationController

    before_action :set_app

    def show
      render plain: @app.first_run_url
      # render plain: @app.blueprint[:first_run_url]
    end

  end
end
