module Installs
  class BuildReportsController < ApplicationController

    before_action :set_engines_system

    def show
      render plain: App.find_by(name: params[:app_name]).core_app.build_report
    end

  end
end
