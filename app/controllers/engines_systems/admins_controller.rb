module EnginesSystems
  class AdminsController < ApplicationController

    before_action :set_engines_system

    def show
      @email = @engines_system.build_email
    end

  end
end
