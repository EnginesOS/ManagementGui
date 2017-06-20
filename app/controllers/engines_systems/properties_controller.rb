module EnginesSystems
  class PropertiesController < ApplicationController

    before_action :set_engines_system

    def edit
    end

    def update
      if @engines_system.update(strong_params)
        EnginesSystemViewUpdateJob.perform_later(@engines_system)
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
