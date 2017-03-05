module Apps
  module ServiceConsumers
    class NonPersistentDestroysController < ApplicationController

      before_action :set_app

      def destroy
        @non_persistent_service_consumer_remove = @app.
            build_non_persistent_service_consumer_remove(
              publisher_type_path: params[:publisher_type_path],
              service_handle: params[:service_handle] )
        if @non_persistent_service_consumer_remove.remove_from_system
          flash.now[:notice] =
            "Successfully deleted #{@non_persistent_service_consumer_remove.label} "\
            "for #{@app.name}."
          render 'apps/service_consumers/index'
        else
          flash.now[:alert] =
            "Failed to delete #{@non_persistent_service_consumer_remove.label} "\
            "for #{@app.name}."
          render 'show'
        end
      end

   end

 end
end
