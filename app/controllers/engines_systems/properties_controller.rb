module EnginesSystems
  class PropertiesController < ApplicationController

    before_action :set_engines_system
    # before_action :set_cloud

    def edit
      # @engines_system_display_properties = @engines_system.display_properties
    end

    def update
      if @engines_system.update(strong_params)
        render
      else
        render 'edit'
      end
    end

    private

    def strong_params
      params.require(:engines_system).permit(:label, :url, :token)
    end

  end
end
