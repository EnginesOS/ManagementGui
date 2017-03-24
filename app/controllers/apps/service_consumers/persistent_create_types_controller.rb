module Apps
  module ServiceConsumers
    class PersistentCreateTypesController < ApplicationController

      before_action :set_app

      def new
        @persistent_service_consumer_constructor_type = @app.
            build_persistent_service_consumer_constructor_type(
              publisher_type_path: params[:publisher_type_path] )
      end

      def create
        @persistent_service_consumer_constructor_type = @app.
                build_persistent_service_consumer_constructor_type(strong_params)
        case @persistent_service_consumer_constructor_type.create_type.to_sym
        when :existing
          @persistent_service_consumer_share_constructor =
            @persistent_service_consumer_constructor_type.build_share_constructor
          render 'apps/service_consumers/persistent_create_shares/new'
        when :orphan
          @persistent_service_consumer_orphan_constructor =
            @persistent_service_consumer_constructor_type.build_orphan_constructor
          render 'apps/service_consumers/persistent_orphan_creates/new'
        else
          @persistent_service_consumer_constructor =
            @persistent_service_consumer_constructor_type.build_constructor
          render 'apps/service_consumers/persistent_creates/new'
        end
      end

      private

      def strong_params
        params.
        require(:app_core_resources_service_consumer_persistent_constructor_type).
        permit(
          :publisher_type_path,
          :create_type,
          :existing_service,
          :orphan_service )
     end

   end
  end
end
