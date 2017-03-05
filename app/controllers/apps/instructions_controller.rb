module Apps
 class InstructionsController < ApplicationController

   before_action :set_app

   def show
     @action_result = @app.perform_instruction(params[:app_instruction])
   end

 end
end
