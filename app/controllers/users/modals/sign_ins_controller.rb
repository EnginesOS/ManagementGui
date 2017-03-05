module Users
  module Modals
    class SignInsController < ApplicationController

      def show
      end

      helper_method :resource_name, :resource_class, :resource, :devise_mapping

      def resource_name
        :user
      end

      def resource
        @resource ||= User.new
      end

      def resource_class
        User
      end

      def devise_mapping
        @devise_mapping ||= Devise.mappings[:user]
      end

    end
  end
end
