module EnginesSystems
  module Keys
    class DownloadsController < ApplicationController

      before_action :set_engines_system

      def show
        @key = @engines_system.build_key
        @key_file = @key.file_from_system
        if @key_file
          send_data @key_file,  :filename => "engines_ssh_public_key.rsa"
        else
          redirect_to cloud_path(cloud_id: @engines_system.cloud.id), alert: 'Failed to retreive public SSH key from the Engines system.'
        end
      end

    end
  end
end
