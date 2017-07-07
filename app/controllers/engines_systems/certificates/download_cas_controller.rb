module EnginesSystems
  module Certificates
    class DownloadCasController < ApplicationController

      before_action :set_engines_system

      def show
        @system_ca = @engines_system.build_system_ca_download
        @system_ca_file = @system_ca.file_from_system
        if @system_ca_file
          send_data @system_ca_file,  :filename => "EnginesCA.crt"
        else
          flash[:alert] = 'Failed to retrieve system CA from the Engines system.'
          render 'show_fail'
        end
      end

    end
  end
end
