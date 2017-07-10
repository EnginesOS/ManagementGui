module EnginesSystems
  module Certificates
    class DestroysController < ApplicationController

      before_action :set_engines_system

      def destroy
        @certificate_delete = @engines_system.build_certificate_delete(certificate_path: params[:certificate_path])
        if @certificate_delete.update_system
          flash.now[:notice] = 'The certificate has been successfully deleted from the system.'
          render 'engines_systems/certificates/index'
        else
          flash.now[:alert] = 'Failed to delete the certificate from the system.'
          render 'engines_systems/certificates/index'
        end
      end

    end
  end
end
