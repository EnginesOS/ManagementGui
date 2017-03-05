module Clouds
  class PropertiesController < ApplicationController

    before_action :set_cloud

    def edit
    end

    def update
      if @cloud.update(strong_params)
        # redirect_to cloud_path(
        #   cloud_id: @cloud.id),
        #   notice: "Cloud properties for #{@cloud.label} were successfully updated."
        render
      else
        render 'edit'
      end
    end

    private

    def strong_params
      params.require(:cloud).permit(
        :label, :admin_banner, :portal_center_align, :portal_header,
        :portal_footer, :text_color, :background_color, :icon, :icon_clear)
    end

  end
end
