module Apps
  module ServiceConsumers
    class PersistentSubserviceRegistrationsController < ApplicationController

      before_action :set_app

      def show
        @non_persistent_service_consumer = @app.
            build_non_persistent_service_consumer(
              publisher_type_path: params[:publisher_type_path],
              service_handle: params[:service_handle] )
        @non_persistent_service_consumer.registration(params[:registration_action])
        flash.now[:notice] =
          "Successfully performed #{params[:registration_action]} on #{@non_persistent_service_consumer.label} "\
          "for #{@app.name}."
      rescue EnginesError => e
        flash.now[:alert] =
          "Failed to perform #{params[:registration_action]} on #{@non_persistent_service_consumer.label} "\
          "for #{@app.name}. (#{@non_persistent_service_consumer.exception})"
        render 'apps/service_consumers/non_persistents/show'
      end

   end
  end
end
