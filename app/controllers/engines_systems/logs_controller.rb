module EnginesSystems
  class LogsController < ApplicationController

    before_action :set_engines_system

    def show
      render js: "alert('Does the API support system logs?');"
    end

  end
end
