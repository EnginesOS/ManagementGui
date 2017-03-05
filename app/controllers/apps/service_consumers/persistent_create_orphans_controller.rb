module Apps
  module ServiceConsumers
    class PersistentCreateOrphansController < ApplicationController

      before_action :set_app

      def create
        @persistent_service_consumer_orphan_constructor = @app.
                build_persistent_service_consumer_orphan_constructor(strong_params)
        if @persistent_service_consumer_orphan_constructor.valid?
          create_service_consumer
        else
          render 'new'
        end
      end

      def create_service_consumer
        if @persistent_service_consumer_orphan_constructor.save_to_system
          flash.now[:notice] =
            "Successfully adopted "\
            "#{@persistent_service_consumer_orphan_constructor.label} service "\
            "for #{@app.name}."
        else
          flash.now[:alert] =
            "Failed to adopt "\
            "#{@persistent_service_consumer_orphan_constructor.label} service "\
            "for #{@app.name}."
        end
        render 'apps/service_consumers/index'
      end

      private

      def strong_params
        params.
        require(:app_core_resources_service_consumer_persistent_orphan_constructor).
        permit(
          :publisher_type_path,
          :parent_engine,
          :service_handle,
          fields_attributes: Field.form_attributes )
     end

   end
  end
end
