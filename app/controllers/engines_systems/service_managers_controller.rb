module EnginesSystems
  class ServiceManagersController < ApplicationController

    before_action :set_engines_system

    def show
      @service_manager = @engines_system.build_service_manager
    end

  end
end
