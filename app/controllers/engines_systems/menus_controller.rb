module EnginesSystems
  class MenusController < ApplicationController

    before_action :set_engines_system

    def show
      EnginesSystemViewUpdateJob.perform_later(@engines_system)
      render
    end

  end
end
