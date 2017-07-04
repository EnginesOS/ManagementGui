module Apps
  class ClearHadOomsController < ApplicationController

    before_action :set_app

    def show
      @app.core_app.clear_had_oom
      EnginesSystemViewUpdateJob.perform_later(@app.engines_system)
      render '/apps/menus/show'
    end

  end
end
