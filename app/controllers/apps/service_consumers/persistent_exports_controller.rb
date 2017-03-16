module Apps
  module ServiceConsumers
    class PersistentExportsController < ApplicationController

      before_action :set_app

      def show
        @persistent_service_consumer_export = @app.
            build_persistent_service_consumer_export(
              publisher_type_path: params[:publisher_type_path],
              # service_container_name: params[:service_container_name],
              service_handle: params[:service_handle] )
        @data_file = @persistent_service_consumer_export.file
        if @data_file
          
          send_data @data_file, :filename => "engines_data_export_#{@app.name}__#{params[:publisher_type_path].gsub '/', '_'}_#{params[:service_handle]}__#{Time.now.utc}.gzip"
        else
          redirect_to cloud_path(cloud_id: @app.cloud.id), alert: "Failed to export data from #{params[:service_handle]} for #{@app.name}."
        end
      end

   end
  end
end
