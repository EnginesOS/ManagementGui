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
         flash.now[:notice] = "Successfully updated memory settings for #{@app.name}."
       else
         flash.now[:alert] = "Failed to update memory settings for #{@app.name}."
       end
       render 'apps/control_panels/show'
     else
       render 'edit'
     end
   rescue EnginesError => e
     raise EnginesError.new "Failed to update memory settings for #{@app.name}.\n\n#{e}"
   end

   private

   def strong_params
     params.require(:app_core_resources_memory).permit(
       :limit, :minimum, :recommended)
   end

 end
end
