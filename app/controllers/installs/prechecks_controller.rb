module Installs
  class PrechecksController < ApplicationController

    before_action :set_engines_system

    def show
      if @engines_system.building?
        flash[:alert] = 'Please wait for the current installation to complete before starting a new one.'
        redirect_to install_build_path(engines_system_id: @engines_system.id), remote: true
      elsif @engines_system.domains.empty?
        flash.now[:alert] = 'You need to setup a domain name before you can install apps.'
        render 'engines_systems/menus/show'
      elsif @engines_system.cloud.libraries.count == 1
        redirect_to install_library_path(engines_system_id: @engines_system.id, library_id: @engines_system.cloud.libraries.first.id ), remote: true
      else
        redirect_to install_libraries_menu_path(engines_system_id: @engines_system.id, library_id: @engines_system.cloud.libraries.first.id ), remote: true
      end
    end

  end
end
