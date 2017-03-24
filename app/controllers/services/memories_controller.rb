module Services
 class MemoriesController < ApplicationController

   before_action :set_service

   def edit
     @memory = @service.build_memory
   end

   def update
     @memory = @service.build_memory(strong_params)
     if @memory.valid?
       if @memory.update_system
         flash.now[:notice] = "Memory settings for #{@memory.service.name} were successfully updated."
         render 'services/control_panels/show'
       else
         flash.now[@memory.exception.flash_message_params[:type]] =
         "Failed to update memory settings for #{@memory.service.name}. (#{@memory.exception.flash_message_params[:message]})"
         render 'services/control_panels/show'
       end
     else
       render 'edit'
     end
   end

   private

   def strong_params
     params.require(:service_core_resources_memory).permit(
       :memory, :minimum, :recommended)
   end

 end
end
