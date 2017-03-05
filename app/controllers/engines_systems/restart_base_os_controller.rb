module EnginesSystems
  class RestartBaseOsController < ApplicationController

    before_action :set_engines_system

    def show
      if @engines_system.core_system.restart_base_os
        render
      else
        render 'fail'
      end
    end

  end
end
