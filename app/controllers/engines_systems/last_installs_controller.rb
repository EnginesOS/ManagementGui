module EnginesSystems
  class LastInstallsController < ApplicationController

    before_action :set_engines_system

    def show
      @last_build_params = @engines_system.core_system.last_build_params
      @last_build_log = h(@engines_system.core_system.last_build_log.split('\n').reverse.join("\n")).html_safe
    end

  end
end
