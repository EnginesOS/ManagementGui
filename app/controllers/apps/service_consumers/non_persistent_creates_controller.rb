module Apps
  module ServiceConsumers
    class NonPersistentCreatesController < ApplicationController

      before_action :set_app

      def new
        @non_persistent_service_consumer_constructor = @app.
          build_non_persistent_service_consumer_constructor(
          publisher_type_path: params[:publisher_type_path] )
      end

      def create
        @non_persistent_service_consumer_constructor = @app.
        build_non_persistent_service_consumer_constructor(strong_params)
        if @non_persistent_service_consumer_constructor.valid?
          create_service_consumer
        else
          render 'new'
        end
      end

      def create_service_consumer
        if @non_persistent_service_consumer_constructor.save_to_system
          flash.now[:notice] =
            "Successfully created "\
            "#{@non_persistent_service_consumer_constructor.label} service "\
            "for #{@app.name}."
        else
          flash.now[:alert] =
            "Failed to create "\
            "#{@non_persistent_service_consumer_constructor.label} service "\
            "for #{@app.name}."
        end
        render 'apps/service_consumers/index'
      rescue EnginesError => e
        raise EnginesError.new "Failed to create "\
          "#{@non_persistent_service_consumer_constructor.label} service "\
          "for #{@app.name}.\n\n#{e}"
      end

      private

      def strong_params
        params.
        require(:app_core_resources_service_consumer_non_persistent_constructor).
        permit(
          :publisher_type_path,
          fields_attributes: Field.form_attributes )
     end

   end
 end
end
