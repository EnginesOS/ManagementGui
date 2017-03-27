module Apps
  module ServiceConsumers
    class PersistentSubservicesController < ApplicationController

      before_action :set_app

      def new

        @persistent_service_consumer = @app.
            build_persistent_service_consumer(
              publisher_type_path: params[:publisher_type_path],
              service_handle: params[:service_handle] )
      end

      def show
        @persistent_service_consumer_subservice_consumer = @app.
            build_persistent_service_consumer_subservice_consumer(
              publisher_type_path: params[:publisher_type_path],
              service_handle: params[:service_handle],
              subservice_handle: params[:subservice_handle] )
      end

      def edit
        @persistent_service_consumer_subservice_consumer = @app.
            build_persistent_service_consumer_subservice_consumer(
              publisher_type_path: params[:publisher_type_path],
              service_handle: params[:service_handle],
              subservice_handle: params[:subservice_handle] )
      end

      def update
        @persistent_service_consumer_subservice_consumer = @app.
            build_persistent_service_consumer_subservice_consumer(strong_params)
        if @persistent_service_consumer_subservice_consumer.valid? && @persistent_service_consumer_subservice_consumer.save_to_system
          flash.now[:notice] =
            "Successfully updated #{@persistent_service_consumer_subservice_consumer.label} "\
            "for #{@app.name}."
          render 'show'
        else
          render 'edit'
        end
      rescue EnginesError => e
      else
        flash.now[:alert] =
          "Failed to update #{@persistent_service_consumer_subservice_consumer.label} "\
          "for #{@app.name}. (#{@persistent_service_consumer_subservice_consumer.exception})"
        render 'show'
      end

      private

      def strong_params
        params.
        require(:app_core_resources_service_consumer_persistent).
        permit(
          :publisher_type_path,
          :service_handle,
          :subservice_publisher_type_path,
          fields_attributes: Field.form_attributes )
     end

   end
  end
end
