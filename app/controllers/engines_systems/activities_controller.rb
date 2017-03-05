module EnginesSystems
  class ActivitiesController < ApplicationController

    before_action :set_engines_system

    def show
      @activity = @engines_system.build_activity
    end

  end
end
