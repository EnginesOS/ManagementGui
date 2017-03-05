module Apps
 class ReinstallsController < ApplicationController

   before_action :set_app

   def show
     if @app.engines_system.building?
       flash.now[:alert] = 'Please wait for the current installation to complete before starting a new one.'
       render 'installs/builds/show'
     elsif @app.perform_instruction(:reinstall)
       render 'installs/builds/show'
     else
       flash.now[:alert] = "Failed to reinstall #{@app.name}."
       render 'apps/menus/show'
     end
   end

 end
end
