module EnginesSystems
  class RegistriesController < ApplicationController

    before_action :set_engines_system

    def show
      @registry = @engines_system.build_registry
    end

  end
end
