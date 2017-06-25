module EnginesSystems
  class RestartEnginesController < ApplicationController

    before_action :set_engines_system

    def show
      if @engines_system.core_system.restart_engines
        EnginesSystemViewUpdateJob.perform_later(@engines_system, 'Restart Engines')
        render
      else
        render 'fail'
      end
    end

  end
end
