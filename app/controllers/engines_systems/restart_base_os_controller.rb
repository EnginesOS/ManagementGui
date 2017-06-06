module EnginesSystems
  class RestartBaseOsController < ApplicationController

    before_action :set_engines_system

    def show
      if @engines_system.core_system.restart_base_os
        EnginesSystemViewUpdateJob.perform_now(@engines_system, 'Restart system.')
        render
      else
        render 'fail'
      end
    rescue EnginesError::ApiRetryConnectionError
      # rescue because system may restart immediately, before returning, which throws error
      EnginesSystemViewUpdateJob.perform_now(@engines_system, 'Restart system.')
      render
    end

  end
end
