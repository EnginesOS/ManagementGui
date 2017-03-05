module EnginesSystems
  module Keys
    class UploadsController < ApplicationController

      before_action :set_engines_system

      def new
        @key = @engines_system.build_key
      end

      def create
        @key = @engines_system.build_key(strong_params)
        if @key.update_system
          flash.now[:notice] = 'The public key has been successfully saved to the system.'
          render 'engines_systems/keys/show'
        else
          flash.now[:alert] = 'Failed to save the public key to the system.'
          render 'engines_systems/keys/show'
        end
      end

      private

      def strong_params
        params.require(:engines_system_core_resources_key).permit(:key)
      rescue => e
        return {} if e.is_a? NoMethodError
      end

    end
  end
end
