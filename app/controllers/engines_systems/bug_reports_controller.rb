module EnginesSystems
  class BugReportsController < ApplicationController

    before_action :set_engines_system

    def edit
      @bug_report = @engines_system.build_bug_report
    end

    def update
      @bug_report = @engines_system.build_bug_report(strong_params)
      if @bug_report.update_system
        flash.now[:notice] = 'Successfully updated bug report settings.'
        render 'engines_systems/control_panels/show'
      else
        flash.now[:alert] = 'Failed to update bug report settings.'
        render 'edit'
      end
    end

    private

    def strong_params
      params.require(:engines_system_core_resources_bug_report).permit(:send_bug_reports)
    end

  end
end
