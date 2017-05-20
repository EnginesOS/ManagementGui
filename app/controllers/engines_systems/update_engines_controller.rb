module EnginesSystems
  class UpdateEnginesController < ApplicationController

    before_action :set_engines_system
    # before_action :set_cloud

    def show
      if !@engines_system.core_system.update_engines
        render
      else
        flash.now[:notice] = "Engines is already up to date."
        render 'fail'
      end
    end

  end
end
