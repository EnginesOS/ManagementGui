module Apps
 class PropertiesController < ApplicationController

   before_action :set_app

   def edit
   end

   def update
     if @app.update(strong_params)
       EnginesSystemViewUpdateJob.perform_later(@app.engines_system)
       flash.now[:notice] = "Successfully updated app properties."
       render
     else
       render 'edit'
     end
   end

   private

   def strong_params
     params.require(:app).permit(
       :label, :title, :icon, :icon_clear,
       :show_on_portal, :portal_link,
       :portal_worker_message)
   end

 end
end
