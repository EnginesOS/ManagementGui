module EnginesSystems
  module Certificates
    module Uploads
      class PrivateKeysController < ApplicationController

        before_action :set_engines_system

        def create
          @certificate_private_key = @engines_system.build_certificate_upload_private_key(strong_params)
          if @certificate_private_key.valid?
            # if @certificate_private_key.save_to_tmp
              @certificate_target = @engines_system.
                  build_certificate_upload_target(
                    certificate_string: @certificate_private_key.certificate_string,
                    certificate_cname: @certificate_private_key.certificate_cname,
                    private_key_string: @certificate_private_key.private_key_string,
                    password: @certificate_private_key.password)
              render 'engines_systems/certificates/uploads/targets/new'
            # else
              # flash.now[:alert] = 'Failed to add certificate. Could not save the private key.'
              # render 'engines_systems/certificates/manage/show'
            # end
          else
            render 'new'
          end
        end
        #
        # private
        #
        # def strong_params
        #   params.require(:engines_system_core_resources_certificate_upload_private_key).
        #   permit(:certificate_for, :key, :password, :host_domain, :tmp_filename, :cname)
        # end
        private

        def strong_params
          params.require(:engines_system_core_resources_certificate_upload_private_key).
            permit( :certificate_string, :certificate_cname, :password,
                    :private_key_file_upload, :private_key_input, :private_key_upload_method_selection)
        # rescue ActionController::ParameterMissing # is thrown when user does not attach a file to form. Would have expected Rails to return empty params rather than error.
        #   {}
        end

      end
    end
  end
end
