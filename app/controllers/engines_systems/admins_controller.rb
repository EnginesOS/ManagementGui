module EnginesSystems
  class AdminsController < ApplicationController

    before_action :set_engines_system

    def show
      @admin = current_user
    end

  end
end
