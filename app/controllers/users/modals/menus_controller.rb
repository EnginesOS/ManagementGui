module Users
  module Modals
    class MenusController < ApplicationController

      def show
        @user = current_user
      end

    end
  end
end
