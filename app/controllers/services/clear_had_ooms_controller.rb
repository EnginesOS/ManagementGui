module Services
  class ClearHadOomsController < ApplicationController

    before_action :set_service

    def show
      @service.core_service.clear_had_oom
      EnginesSystemViewUpdateJob.perform_later(@service.engines_system)
      render '/services/menus/show'
    end

  end
end
