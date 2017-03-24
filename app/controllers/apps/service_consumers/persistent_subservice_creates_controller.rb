module Apps
  module ServiceConsumers
    class PersistentSubserviceCreatesController < ApplicationController

      before_action :set_app

      def new
        @persistent_service_consumer_subservices_consumer_constructor = @app.
          build_persistent_service_consumer_subservice_consumer_constructor(
          parent_service_handle: params[:parent_service_handle],
          parent_publisher_type_path: params[:parent_publisher_type_path],
          publisher_type_path: params[:publisher_type_path] )
      end

      def create
        @persistent_service_consumer_subservices_consumer_constructor = @app.
        build_persistent_service_consumer_subservice_consumer_constructor(strong_params)
        if @persistent_service_consumer_subservices_consumer_constructor.valid?
          create_service_consumer
        else
          render 'new'
        end
      end

      def create_service_consumer
        if @persistent_service_consumer_subservices_consumer_constructor.save_to_system
          flash.now[:notice] =
            "Successfully created "\
            "#{@persistent_service_consumer_subservices_consumer_constructor.label} service "\
            "for #{@app.name}."
        else
          flash.now[:alert] =
            "Failed to create "\
            "#{@persistent_service_consumer_subservices_consumer_constructor.label} service "\
            "for #{@app.name}."
        end
        render 'apps/service_consumers/index'
      end

      private

      def strong_params
        params.
        require(:app_core_resources_service_consumer_persistent_subservice_constructor).
        permit(
          :publisher_type_path,
          :parent_publisher_type_path,
          :parent_service_handle,
          fields_attributes: Field.form_attributes )
     end







      # def new
      #   @persistent_service_consumer_subservices_consumer = @app.
      #       build_persistent_service_consumer_subservice_consumer_constructor(
      #         publisher_type_path: params[:publisher_type_path] )
      # #   @persistent_service_consumer_subservices_consumer = @app.
      # #       build_persistent_service_consumer_subservices_consumer(
      # #         type_path: params[:type_path] )
      # #   if @persistent_service_consumer_subservices_consumer.fields.empty?
      # #     create_service_consumer
      # #   else
      # #     render
      # #   end
      # end
      # #
      # def create
      #   @persistent_service_consumer_subservices_consumer = @app.
      #           build_persistent_service_consumer_subservice_consumer_constructor(strong_params)
      #   if @persistent_service_consumer_subservices_consumer.valid?
      #     create_service_consumer
      #   else
      #     render 'new'
      #   end
      # end
      #
      # def create_service_consumer
      #   if @persistent_service_consumer_subservices_consumer.save_to_system
      #     flash.now[:notice] =
      #       "Successfully created service consumer for #{@persistent_service_consumer_subservices_consumer.label}."
      #   else
      #     flash.now[:alert] =
      #       "Failed to create service consumer for #{@persistent_service_consumer_subservices_consumer.label}."
      #   end
      #   render 'apps/service_consumers/index'
      # end
      #
      # private
      #
      # def strong_params
      #   params.
      #   require(:app_core_resources_service_consumer_non_persistent_constructor).
      #   permit(
      #     :service_container_name,
      #     :publisher_type_path,
      #     fields_attributes: Field.form_attributes )
      # end

   end

 end
end
