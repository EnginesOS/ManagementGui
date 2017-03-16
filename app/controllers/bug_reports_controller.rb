class BugReportsController < ApplicationController

  def create
    
    begin
      RestClient.post(Rails.application.config.bug_reports_server.to_s + '/v0/bug_reports', strong_params[:data], headers={"Content-Type" => "application/json"})
    rescue
    ensure
      redirect_to(:back)
    end
  end

  private

  def strong_params
    params.require(:bug_report).permit(:data)
  end

end
