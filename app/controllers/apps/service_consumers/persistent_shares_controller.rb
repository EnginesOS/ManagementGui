module Apps
  module ServiceConsumers
    class PersistentSharesController < ApplicationController

      before_action :set_app

      def show
        @persistent_service_consumer_share = @app.
          build_persistent_service_consumer_share(
            parent_engine: params[:parent_engine],
            publisher_type_path: "#{params[:publisher_type_path]}",
            service_handle: params[:service_handle] )
      end

      def edit
        @persistent_service_consumer_share = @app.
          build_persistent_service_consumer_share(
            parent_engine: params[:parent_engine],
            publisher_type_path: "#{params[:publisher_type_path]}",
            service_handle: params[:service_handle] )
      end

      def update
        @persistent_service_consumer_share = @app.
                build_persistent_service_consumer_share(strong_params)
        if @persistent_service_consumer_share.valid?
          if @persistent_service_consumer_share.save_to_system
            flash.now[:notice] =
              "Successfully updated #{@persistent_service_consumer_share.label} "\
              "for #{@app.name}."
          else
            flash.now[:alert] =
              "Failed to update #{@persistent_service_consumer_share.label}."\
              "for #{@app.name}."
          end
          render 'show'
        else
          render 'edit'
        end
      rescue EnginesError => e
        raise EnginesError.new "Failed to update "\
          "#{@persistent_service_consumer_share.label}."\
          "for #{@app.name}.\n\n#{e}"
      end

      def destroy
        @persistent_service_consumer_share = @app.
            build_persistent_service_consumer_share(
              parent_engine: params[:parent_engine],
              publisher_type_path: params[:publisher_type_path],
              service_handle: params[:service_handle] )
        @persistent_service_consumer_share.remove_from_system
        flash.now[:notice] =
          "Successfully deleted #{@persistent_service_consumer_share.label} "\
          "for #{@app.name}."
        render 'apps/service_consumers/index'
      rescue EnginesError => e
        flash.now[:alert] =
          "Failed to delete #{@persistent_service_consumer_share.label} "\
          "for #{@app.name}."
        render 'show'
      end

      private

      def strong_params
        params.
        require(:app_core_resources_service_consumer_persistent_share).
        permit(
          :parent_engine,
          :publisher_type_path,
          :service_handle,
          fields_attributes: Field.form_attributes )
     end

   end
  end
end
