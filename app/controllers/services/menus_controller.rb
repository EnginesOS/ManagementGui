module Services
 class MenusController < ApplicationController

   before_action :set_service

   def show
     EnginesSystemViewUpdateJob.perform_now(@service.engines_system)
   end

 end
end
