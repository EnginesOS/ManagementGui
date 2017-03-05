module EnginesSystems
  class UpdatesController < ApplicationController

    before_action :set_engines_system
    # before_action :set_cloud

    def show
      # @engines_system = current_user.user_profile.engines_systems.find(params[:engines_system_id])
      # render js: "alert('#{@engines_system.label}');"
    end

  end
end
