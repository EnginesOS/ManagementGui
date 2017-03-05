module EnginesSystems
  module Keys
    class GeneratesController < ApplicationController

      before_action :set_engines_system
      # before_action :set_cloud

      def show
        @key = @engines_system.build_key
        @new_private_key = @key.generate_key
        if @new_private_key
          send_data @new_private_key, filename: "engines_private_key.rsa"
        else
          flash[:alert] = 'Failed to generate new private SSH key.'
          redirect_to cloud_path(cloud_id: @engines_system.cloud.id)
        end
      end

    end
  end
end
