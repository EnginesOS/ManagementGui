module EnginesSystems
  module Certificates
    class DownloadsController < ApplicationController

      before_action :set_engines_system

      def show
        @certificate = @engines_system.build_certificate_download(certificate_path: params[:certificate_path])
        @certificate_file = @certificate.file_from_system
        if @certificate_file
          send_data @certificate_file,  :filename => "EnginesCA.crt"
        else
          redirect_to cloud_path, alert: 'Failed to retrieve certificate from the Engines system.'
        end
      end

    end
  end
end
