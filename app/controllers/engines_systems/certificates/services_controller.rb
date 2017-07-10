module EnginesSystems
  module Certificates
    class ServicesController < ApplicationController

      before_action :set_engines_system

      def edit
        @service_certificate = @engines_system.build_service_certificate(service_name: params[:service_name])
      end

      def update
        @service_certificate = @engines_system.build_service_certificate({service_name: params[:service_name]}.merge strong_params)
        if @service_certificate.update_system
          flash.now[:notice] = "Successfully applied #{@service_certificate.cert_name} to #{@service_certificate.service_name}."
        else
          flash.now[:error] = "Failed to apply #{@service_certificate.cert_name} to #{@service_certificate.service_name}."
        end
        render 'engines_systems/certificates/show'
      end

      def strong_params
        params.require(:engines_system_core_resources_certificate_service).permit(:cert_name)
      end

    end
  end
end
