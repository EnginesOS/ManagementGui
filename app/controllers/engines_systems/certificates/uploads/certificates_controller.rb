module EnginesSystems
  module Certificates
    module Uploads
      class CertificatesController < ApplicationController

        before_action :set_engines_system

        def new
          @certificate = @engines_system.build_certificate_upload
        end

        def create
          @certificate = @engines_system.build_certificate_upload(strong_params)
          if @certificate.valid?
            # if @certificate.save_to_tmp
              @certificate_private_key = @engines_system.
                  build_certificate_upload_private_key(
                    certificate_string: @certificate.certificate_string, certificate_cname: @certificate.certificate_cname  )
              render 'engines_systems/certificates/uploads/private_keys/new'
            # else
            #   flash.now[:alert] = 'Failed to add certificate. The certificate may be invalid.'
            #   render 'engines_systems/certificates/manage/show'
            # end
          else
            render 'new'
          end
        end


        # def create
        #   @certificate = @engines_system.build_certificate_upload(strong_params)
        #   if @certificate.save_certificate_to_tmp_file
        #     @certificate_detail = @engines_system.
        #     build_certificate_upload_detail(
        #       tmp_filename: @certificate.filename, cname: @certificate.cname  )
        #     flash.now[:notice] = 'The file contains a valid SSL certificate.'
        #     render 'engines_systems/certificates/details/new'
        #   else
        #     render 'new'
        #   end
        # end

        private

        def strong_params
          params.require(:engines_system_core_resources_certificate_upload_certificate).
          permit( :certificate_file_upload, :certificate_input, :certificate_upload_method_selection)
        # rescue ActionController::ParameterMissing # is thrown when user does not attach a file to form. Would have expected Rails to return empty params rather than error.
        #   {}
        end

      end
    end
  end
end
