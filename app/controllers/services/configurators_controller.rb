module Services
  class ConfiguratorsController < ApplicationController

    before_action :set_service

    def edit
      @service_configurator = @service.build_configurator(configurator_name: params[:configurator_name])
    end

    def update
      @service_configurator = @service.build_configurator(strong_params)
      if @service_configurator.valid?
        if @service_configurator.save_to_system
          flash.now[:notice] = "Sucessfully updated configuration "\
            "#{@service_configurator.to_label} for #{@service.name}."
        else
          flash.now[:alert] = "Failed to update configuration "\
            "#{@service_configurator.to_label} for #{@service.name}."
        end
        render 'services/configurations/show'
      else
        render 'edit'
      end
    rescue EnginesError => e
      raise EnginesError.new "Failed to update configuration "\
        "#{@service_configurator.to_label} for #{@service.name}.\n\n#{e}"
    end

    private

    def strong_params
      params.require(:service_core_resources_configurator).permit(
      :configurator_name,
      fields_attributes: Field.form_attributes )
    end

  end
end
