module Services
 class InstructionsController < ApplicationController

   before_action :set_service

   def show
     @action_result = @service.perform_instruction(params[:service_instruction])
   end

 end
end
