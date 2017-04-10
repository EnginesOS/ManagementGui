module Apps
  module ServiceConsumers
    class NonPersistentsController < ApplicationController

      before_action :set_app

      def show
        @non_persistent_service_consumer = @app.
            build_non_persistent_service_consumer(
              publisher_type_path: params[:publisher_type_path],
              service_handle: params[:service_handle] )
      end

      def edit
        @non_persistent_service_consumer = @app.
            build_non_persistent_service_consumer(
              publisher_type_path: params[:publisher_type_path],
              service_handle: params[:service_handle] )
      end

      def update
        @non_persistent_service_consumer = @app.
                build_non_persistent_service_consumer(strong_params)
        if @non_persistent_service_consumer.valid? && @non_persistent_service_consumer.save_to_system
          flash.now[:notice] =
            "Successfully updated #{@non_persistent_service_consumer.label} "\
            "for #{@app.name}."
          render 'apps/service_consumers/non_persistents/show'
        else
          render 'apps/service_consumers/non_persistents/edit'
        end
      rescue EnginesError => e
        flash.now[:alert] =
          "Failed to update #{@non_persistent_service_consumer.label} "\
          "for #{@app.name}. #{e}"
        render 'apps/service_consumers/non_persistents/show'
      end

      private

      def strong_params
        params.
        require(:app_core_resources_service_consumer_non_persistent).
        permit(
          :publisher_type_path,
          :service_handle,
          fields_attributes: Field.form_attributes )
     end

   end

 end
end
