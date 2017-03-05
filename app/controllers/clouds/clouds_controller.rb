module Clouds
  class CloudsController < ApplicationController

    before_action :set_cloud

    def show
      # render text: @cloud.engines_systems.first.apps.map(&:id)
    end

  end
end
