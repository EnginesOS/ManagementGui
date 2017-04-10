module Apps
  module ServiceConsumers
    class PersistentImportsController < ApplicationController

      before_action :set_app

      def new
        @persistent_service_consumer_import = @app.
            build_persistent_service_consumer_import(
              publisher_type_path: params[:publisher_type_path],
              service_handle: params[:service_handle] )
      end

      def create
        @persistent_service_consumer_import = @app.
            build_persistent_service_consumer_import(strong_params)
        if @persistent_service_consumer_import.valid? && @persistent_service_consumer_import.save_to_system
          flash.now[:notice] = "Successfully upload data to #{@persistent_service_consumer_import.label} for #{@app.name}."
          show_persistent_service_consumer
        else
          render 'new'
        end
      rescue EnginesError => e
        flash.now[:alert] = "Failed to upload data to #{@persistent_service_consumer_import.label} for #{@app.name}. (#{e})"
        show_persistent_service_consumer
      end

      def show_persistent_service_consumer
        @persistent_service_consumer = @app.
            build_persistent_service_consumer(
              publisher_type_path: strong_params[:publisher_type_path],
              service_handle: strong_params[:service_handle] )
        render 'apps/service_consumers/persistents/show'
      end

      private

      def strong_params
        params.
        require(:app_core_resources_service_consumer_persistent_import).
        permit(
          :publisher_type_path,
          :service_handle,
          :data_file,
          :write )
      end

    end
  end
end
