module Services
 class RebuildsController < ApplicationController

   before_action :set_service

   def show
     render js: "alert('Does the API support service rebuild?');"
   end

 end
end
