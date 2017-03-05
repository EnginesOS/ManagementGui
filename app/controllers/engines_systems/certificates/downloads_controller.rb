module EnginesSystems
  module Certificates
    class DownloadsController < ApplicationController

      before_action :set_engines_system

      def show
        @certificate = @engines_system.build_certificate_download(domain_name: params[:domain_name])
        @certificate_file = @certificate.file_from_system
        if @certificate_file
          send_data @certificate_file,  :filename => "engines_certificate.pem"
        else
          redirect_to cloud_path, alert: 'Failed to retrieve certificate from the Engines system.'
        end
      end

    end
  end
end
