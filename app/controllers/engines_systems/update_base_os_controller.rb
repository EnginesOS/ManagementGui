module EnginesSystems
  class UpdateBaseOsController < ApplicationController

    before_action :set_engines_system
    # before_action :set_cloud

    def show
      if @engines_system.core_system.update_base_os
        EnginesSystemViewUpdateJob.perform_later(@engines_system, "Updating Base OS #{@engines_system.base_system_version[:name]}")
        render
      else
        flash.now[:notice] = "Base OS is already up to date."
        render 'fail'
      end
    end

  end
end
