module Services
 class VariablesController < ApplicationController

   def edit
     @service_variables = Service::Variables.new(service_name: params[:service_name])
     @service_variables.setup_environment_variables
   end

   def update
     @service_variables = Service::Variables.new(service_name: params[:service_name])
     @service_variables.service.assign_attributes(strong_params)
     if @service_variables.valid?
       if @service_variables.save_to_system
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
     params.require(:service).permit(
       environment_variables_attributes: [
         :ask_at_build_time, :build_time_only,
         field_attributes: Field.form_attributes ] )
   end

 end
end
