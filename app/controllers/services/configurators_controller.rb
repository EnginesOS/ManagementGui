module Services
 class ConfiguratorsController < ApplicationController

   before_action :set_service

   def edit
     @service_configurator = @service.build_configurator(configurator_name: params[:configurator_name])
   end

   def update
     @service_configurator = @service.build_configurator(strong_params)
     if @service_configurator.valid?
       if @service_configurator.save_to_system
         flash.now[:notice] = "Sucessfully updated configuration."
         render 'services/configurations/show'
       else
         if @service_configurator.exception
           flash.now[@service_configurator.exception.flash_message_params[:type]] =
           "#{@service_configurator.exception}"
         end
         render 'services/configurations/show'
       end
     else
       render 'edit'
     end
   end

   private

   def strong_params
     params.require(:service_core_resources_configurator).permit(
       :configurator_name,
       fields_attributes: Field.form_attributes )
   end

 end
end
