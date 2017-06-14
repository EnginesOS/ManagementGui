module Services
 class RestartLocalGuisController < ApplicationController

   before_action :set_service

   def show
     @service.perform_instruction(:restart)
     render
   end

 end
end
