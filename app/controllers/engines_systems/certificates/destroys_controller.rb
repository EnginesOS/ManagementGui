module EnginesSystems
  module Certificates
    class DestroysController < ApplicationController

      before_action :set_engines_system

      def destroy
        @certificate_delete = @engines_system.build_certificate_delete(domain_name: params[:domain_name])
        if @certificate_delete.update_system
          flash.now[:notice] = 'The certificate has been successfully deleted from the system.'
          render 'engines_systems/certificates/index'
        else
          flash.now[:alert] = 'Failed to delete the certificate from the system.'
          render 'engines_systems/certificates/index'
        end
      end
      #
      # private
      #
      # def strong_params
      #   params.require(:engines_system_core_resources_certificate_upload_detail).
      #   permit(:certificate_for, :key, :host_domain, :tmp_filename, :cname)
      # end

    end
  end
end
