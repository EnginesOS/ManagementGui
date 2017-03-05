module EnginesSystems
  class BusiesController < ApplicationController

    before_action :set_engines_system

    def show
      if @engines_system.busy?
        render plain: true
      else
        render plain: false
      end
    end

  end
end
