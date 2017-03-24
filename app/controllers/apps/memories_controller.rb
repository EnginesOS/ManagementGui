module Apps
 class MemoriesController < ApplicationController

   before_action :set_app

   def edit
     @memory = @app.build_memory
   end

   def update
     @memory = @app.build_memory(strong_params)
     if @memory.valid?
       if @memory.update_system
         flash.now[:notice] = "Memory settings for #{@memory.app.name} were successfully updated."
         render 'apps/control_panels/show'
       else
         flash.now[@memory.exception.flash_message_params[:type]] =
         "Failed to update memory settings for #{@memory.app.name}. (#{@memory.exception.flash_message_params[:message]})"
         render 'apps/control_panels/show'
       end
     else
       render 'edit'
     end
   end

   private

   def strong_params
     params.require(:app_core_resources_memory).permit(
       :memory, :minimum, :recommended)
   end

 end
end
