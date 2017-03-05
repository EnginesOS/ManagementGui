module Services
 class RestartLocalGuisController < ApplicationController

   before_action :set_service

   def show
     render
     @service.perform_instruction(:restart)
   end

 end
end
