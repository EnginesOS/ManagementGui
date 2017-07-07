module EnginesSystems
  module Certificates
    module Uploads
      class TargetsController < ApplicationController

        before_action :set_engines_system

        def create
          @certificate_target = @engines_system.build_certificate_upload_target(strong_params)
          if @certificate_target.valid?
            if @certificate_target.save_certificate_to_system
              flash.now[:notice] = 'The certificate has been successfully saved to the system.'
            else
              flash.now[:alert] = 'Failed to save the certificate to the system.'
            end
            render 'engines_systems/certificates/manages/show'
          else
            render 'new'
          end
        end

        private

        def strong_params
          params.require(:engines_system_core_resources_certificate_upload_target).
          permit(:certificate_for, :password, :host_domain, :certificate_string, :certificate_cname, :private_key_string, :password, :target)
        end

      end
    end
  end
end
