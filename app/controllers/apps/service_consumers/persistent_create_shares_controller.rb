module Apps
  module ServiceConsumers
    class PersistentCreateSharesController < ApplicationController

      before_action :set_app

      def create
        @persistent_service_consumer_share_constructor = @app.
                build_persistent_service_consumer_share_constructor(strong_params)
        if @persistent_service_consumer_share_constructor.valid?
          create_service_consumer
        else
          render 'new'
        end
      end

      private

      def create_service_consumer
        @persistent_service_consumer_share_constructor.save_to_system
        flash.now[:notice] =
          "Successfully shared "\
          "#{@persistent_service_consumer_share_constructor.label} service "\
          "for #{@app.name}."
        render 'apps/service_consumers/index'
      rescue EnginesError => e
        flash.now[:alert] =
          "Failed to share "\
          "#{@persistent_service_consumer_share_constructor.label} service "\
          "for #{@app.name}. #{e}"
        render 'apps/service_consumers/index'
      end

      def strong_params
        params.
        require(:app_core_resources_service_consumer_persistent_share_constructor).
        permit(
          :publisher_type_path,
          :parent_engine,
          :service_handle,
          fields_attributes: Field.form_attributes )
     end

   end
  end
end
