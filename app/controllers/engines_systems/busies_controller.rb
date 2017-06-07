module EnginesSystems
  class BusiesController < ApplicationController

    before_action :set_engines_system

    def show
      if @engines_system.is_rebooting? ||
          @engines_system.is_base_system_updating? ||
          @engines_system.is_engines_system_updating?
        render plain: true
      else
        render plain: false
      end
    rescue EnginesError::ApiRetryConnectionError
      render plain: true
    end

  end
end
