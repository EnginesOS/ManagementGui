module EnginesSystems
  class ServicesController < ApplicationController

    before_action :set_engines_system

    def index
      @services = @engines_system.services
    end

    # def show
    #   @service = Service.find(params[:id])
    # end

  end
end
