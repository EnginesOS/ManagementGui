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
       else
         flash.now[:alert] = "Failed to update network settings for #{@network.app.name}."
       end
       render 'apps/control_panels/show'
     else
       render 'edit'
     end
   rescue EnginesError => e
     raise EnginesError.new "Failed to update network settings for #{@app.name}.\n\n#{e}"
   end

   private

   def strong_params
     params.require(:app_core_resources_network).permit(
       :host_name, :domain_name, :http_protocol, :current_fqdn)
   end

 end
end
