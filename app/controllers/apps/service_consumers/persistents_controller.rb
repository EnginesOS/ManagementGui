module Apps
  module ServiceConsumers
    class PersistentsController < ApplicationController

      before_action :set_app

      def show
        @persistent_service_consumer = @app.
            build_persistent_service_consumer(
              publisher_type_path: params[:publisher_type_path],
              service_handle: params[:service_handle] )
      end

      def edit
        @persistent_service_consumer = @app.
            build_persistent_service_consumer(
              publisher_type_path: params[:publisher_type_path],
              service_handle: params[:service_handle] )
      end

      def update
        @persistent_service_consumer = @app.
                build_persistent_service_consumer(strong_params)
        if @persistent_service_consumer.valid? && @persistent_service_consumer.save_to_system
          flash.now[:notice] =
            "Successfully updated #{@persistent_service_consumer.label} "\
            "for #{@app.name}."
        else
          render 'edit'
        end
      rescue EnginesError => e
        flash.now[:alert] =
          "Failed to update #{@persistent_service_consumer.label} "\
          "for #{@app.name}. (#{@persistent_service_consumer.exception})"
        render 'show'
      end

      private

      def strong_params
        params.
        require(:app_core_resources_service_consumer_persistent).
        permit(
          :publisher_type_path,
          :service_handle,
          fields_attributes: Field.form_attributes )
     end

   end
  end
end
