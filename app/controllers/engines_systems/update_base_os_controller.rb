module EnginesSystems
  class UpdateBaseOsController < ApplicationController

    before_action :set_engines_system
    # before_action :set_cloud

    def show
      if @engines_system.core_system.update_base_os
        render
      else
        flash.now[:notice] = "Base OS is already up to date."
        render 'fail'
      end
    end

  end
end
