module Apps
  module ServiceConsumers
    class PersistentDestroysController < ApplicationController

      before_action :set_app

      def new
        @persistent_service_consumer_remove = @app.
            build_persistent_service_consumer_remove(
              publisher_type_path: params[:publisher_type_path],
              service_handle: params[:service_handle] )
      end

      def create
        @persistent_service_consumer_remove = @app.
                build_persistent_service_consumer_remove(strong_params)
        if @persistent_service_consumer_remove.remove_from_system
          flash.now[:notice] =
            "Successfully deleted #{@persistent_service_consumer_remove.label} "\
            "for #{@app.name}."
          render 'apps/service_consumers/index'
        else
          flash.now[:alert] =
            "Failed to delete #{@persistent_service_consumer_remove.label} "\
            "for #{@app.name}."
          render 'show'
        end
      end

      private

      def strong_params
        params.
        require(:app_core_resources_service_consumer_persistent_remove).
        permit(
          :publisher_type_path,
          :service_handle,
          :remove_data )
     end

   end
  end
end
