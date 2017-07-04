module EnginesSystems
  module Certificates
    class DetailsController < ApplicationController

      before_action :set_engines_system

      def create
        @certificate_detail = @engines_system.build_certificate_upload_detail(strong_params)
        if @certificate_detail.valid?
          if @certificate_detail.save_certificate_to_system
            flash.now[:notice] = 'The certificate has been successfully saved to the system.'
            render 'engines_systems/certificates/index'
          else
            flash.now[:alert] = 'Failed to save the certificate to the system.'
            render 'engines_systems/certificates/index'
          end
        else
          render 'new'
        end
      end

      private

      def strong_params
        params.require(:engines_system_core_resources_certificate_upload_detail).
        permit(:certificate_for, :key, :password, :host_domain, :tmp_filename, :cname)
      end

    end
  end
end
