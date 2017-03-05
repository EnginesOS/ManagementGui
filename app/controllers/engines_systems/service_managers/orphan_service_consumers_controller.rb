module EnginesSystems
  module ServiceManagers
    class OrphanServiceConsumersController < ApplicationController

      before_action :set_engines_system

      def show
        @service_manager = @engines_system.build_service_manager
      end

      def destroy
        @service_manager = @engines_system.build_service_manager
        if @service_manager.delete_orphan_service_consumer(
            type_path: params[:type_path],
            parent_engine: params[:parent_engine],
            service_handle: params[:service_handle])
          flash.now[:notice] = "Successfully deleted orphan #{params[:service_label]} consumer for #{params[:parent_engine]}."
        else
          flash.now[:alert] = "Failed to delete orphan #{params[:service_label]} consumer for #{params[:parent_engine]}."
        end
        render 'engines_systems/service_managers/show'
      end

    end
  end
end
