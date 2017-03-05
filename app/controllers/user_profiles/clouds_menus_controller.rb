module UserProfiles
  class CloudsMenusController < ApplicationController

    def show
      set_cloud if params[:cloud_id].present?
    end

  end
end
