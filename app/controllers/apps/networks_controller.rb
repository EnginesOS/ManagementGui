module Apps
 class NetworksController < ApplicationController

   before_action :set_app

   def edit
     @network = @app.build_network
   end

   def update
     @network = @app.build_network(strong_params)
     if @network.valid?
       if @network.save_to_system
         flash.now[:notice] = "Network settings for #{@network.app.name} were successfully updated."
         render 'apps/menus/show'
       else
         flash.now[:alert] = "Failed to update network settings for #{@network.app.name}."
         render 'apps/menus/show'
       end
     else
       render 'edit'
     end
   end

   private

   def strong_params
     params.require(:app_core_resources_network).permit(
       :host_name, :domain_name, :http_protocol, :current_fqdn)
   end

 end
end
