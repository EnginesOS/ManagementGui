module Apps
  class EnvironmentGroupsController < ApplicationController

    before_action :set_app

    def show
      @environment_group = @app.build_environment_group(owner_type: params[:owner_type], owner_path: params[:owner_path])
    end

    def edit
      @environment_group = @app.build_environment_group(owner_type: params[:owner_type], owner_path: params[:owner_path])
    end

    def update
      @environment_group = @app.build_environment_group(strong_params)
      if @environment_group.valid?
        if @environment_group.save_to_system
          flash.now[:notice] = "Successfully updated environment variables for #{@app.name}."
          render 'apps/environment_groups/show'
        else
          if @environment_group.exception
            flash.now[@environment_group.exception.flash_message_params[:type]] =
            "#{@environment_group.exception}"
          end
          render 'apps/environment_groups/show'
        end
      else
        render 'edit'
      end
    end

    private

    def strong_params
      params.require(:app_core_resources_environment_group).permit(
        :owner_type, :owner_path,
        fields_attributes: Field.form_attributes )
    end

  end
end
