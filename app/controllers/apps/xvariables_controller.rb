module Apps
 class VariablesController < ApplicationController

   before_action :set_app

   def show


   end

   def edit
     @app_variables = App::Variables.new(app_name: params[:app_name])
     @app_variables.setup_environment_variables
   end

   def update
     @app_variables = App::Variables.new(app_name: params[:app_name])
     @app_variables.app.assign_attributes(strong_params)
     if @app_variables.valid?
       if @app_variables.save_to_system
         render 'update'
       else
         render 'fail'
       end
     else
       render 'edit'
     end
   end

   private

   def strong_params
     params.require(:app).permit(
       environment_variables_attributes: [
        #  :mandatory, :immutable,
         :ask_at_build_time, :build_time_only,
         field_attributes: Field.form_attributes ] )
   end

 end
end
