module Apps
  class ActionatorsController < ApplicationController

    before_action :set_app

    def new
      @actionator = @app.build_actionator( actionator_name: params[:actionator_name] )
      ## Do the action if there are no fields for building a form.
      if @actionator.field_params.empty?
        process_app_action
      else
        render 'new'
      end
    end

    def create
      @actionator = @app.build_actionator(strong_params)
      if @actionator.valid?
        process_app_action
      else
        render 'new'
      end
    end

    private

    def process_app_action
      @actionator.save_to_system
      if @actionator.return_type == 'file'
        send_data @actionator.api_post_result,  :filename => "#{@app.name}_#{@actionator.actionator_name}"
      else
        render 'result'
      end
    end

    def strong_params
      params.require(:app_core_resources_actionator).permit(
        :actionator_name,
        fields_attributes: Field.form_attributes )
    end

  end
end
