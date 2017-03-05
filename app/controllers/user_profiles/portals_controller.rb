module UserProfiles
  class PortalsController < ApplicationController

    def show
      @clouds = current_user.user_profile.clouds
      @apps = current_user.user_profile.shared_apps
      render 'portals/show'
    end

  end
end
