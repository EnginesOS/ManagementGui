module EnginesSystems
  module Certificates
    class UploadsController < ApplicationController

      before_action :set_engines_system

      def new
        @certificate = @engines_system.build_certificate_upload
      end

      def create
        @certificate = @engines_system.build_certificate_upload(strong_params)
        if @certificate.save_certificate_to_tmp_file
          @certificate_detail = @engines_system.
          build_certificate_upload_detail(
            tmp_filename: @certificate.filename, cname: @certificate.cname  )
          flash.now[:notice] = 'The file contains a valid SSL certificate.'
          render 'engines_systems/certificates/details/new'
        else
          render 'new'
        end
      end

      private

      def strong_params
        params.require(:engines_system_core_resources_certificate_upload).permit(:certificate)
      rescue ActionController::ParameterMissing # is thrown when user does not attach a file to form. Would have expected Rails to return empty params rather than error.
        {}
      end

    end
  end
end
