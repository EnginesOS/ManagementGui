module UserProfiles
  class CloudsController < ApplicationController

    def new
      @cloud = current_user.user_profile.clouds.build
    end

    def create
      @cloud = current_user.user_profile.clouds.build(strong_params)
      if @cloud.save
        redirect_to cloud_path(cloud_id: @cloud.id), notice: "Successfully created cloud #{@cloud.label}."
      else
        render 'new'
      end
    end

    def destroy
      set_cloud
      # byebug
      if @cloud.destroy
        flash[:notice] = "Successfully removed cloud #{@cloud.label}."
        redirect_to user_profile_portal_path
      else
        flash.now[:alert] = "Failed to remove cloud #{@cloud.label}."
        render 'user_profiles/clouds_menus/show'
      end
    end

    private

    def strong_params
      params.require(:cloud).permit(:label)
    end

  end
end
