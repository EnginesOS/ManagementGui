module EnginesSystems
  module Certificates
    class DownloadsController < ApplicationController

      before_action :set_engines_system

      def show
        @certificate = @engines_system.build_certificate_download(certificate_path: params[:certificate_path])
        @certificate_file = @certificate.file_from_system
        if @certificate_file
          send_data "@certificate_file",  :filename => "#{params[:certificate_path].split('/').last}.crt"
        else
          flash[:alert] = 'Failed to retrieve certificate from the Engines system.'
          render 'show_fail'
        end
      end

    end
  end
end
