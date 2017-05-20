module Apps
 class MemoriesController < ApplicationController

   before_action :set_app

   def edit
     @memory = @app.build_memory
   end

   def update
     @memory = @app.build_memory(strong_params)
     if @memory.valid? && @memory.update_system
       flash.now[:notice] = "Memory settings for #{@memory.app.name} were successfully updated."
       render 'apps/control_panels/show'
     else
       render 'edit'
     end
   rescue EnginesError => e
     flash.now[:alert] =
     "Failed to update memory settings for #{@memory.app.name}. #{e}"
     render 'apps/control_panels/show'
   end

   private

   def strong_params
     params.require(:app_core_resources_memory).permit(
       :limit, :minimum, :recommended)
   end

 end
end
