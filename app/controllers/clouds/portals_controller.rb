module Clouds
  class PortalsController < ApplicationController

    before_action :set_cloud

    def show
      @show_sign_in = params[:sign_in]
      @apps = @cloud.cloud_portal_apps
      render 'portals/show'
    # rescue
    #   render plain: 'No cloud'
    end

    private

    def set_cloud
      return super if current_user && params[:cloud_id]
      @cloud = User.find_by(username: 'admin').user_profile.clouds.first
    end

  end
end
