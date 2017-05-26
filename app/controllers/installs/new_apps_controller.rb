module Installs
  class NewAppsController < ApplicationController

    before_action :set_engines_system

    def new
      @new_app = @engines_system.build_new_app(install_repository_params)
    rescue EnginesError
      flash.now[:alert] = "Failed to load blueprint from #{install_repository_params[:repository_url]}. #{e}"
      new_fail
    end

    def new_fail
      if @new_app.library_id.present?
        set_library(@new_app.library_id)
        render 'load_blueprint_fail'
      else
        render 'side_load_blueprint_fail'
      end
    end

    def create
      @new_app = @engines_system.build_new_app(install_new_app_params)
      if @new_app.valid?
        if @new_app.install
          @new_app.create_app
          EnginesSystemViewUpdateJob.perform_later(@new_app.engines_system.id)
          render
        else
          flash[:alert] = "Failed to install #{@new_app.container_name} from #{@repository.repository_url}."
          render 'create_fail'
        end
      else
        render 'new'
      end
    end

    private

    def install_new_app_params
      strong_install_new_app_params.tap do |result|
        result[:environment_variables_attributes] = { fields_attributes: {} } unless result[:environment_variables_attributes]
        result[:service_consumers_attributes] = {} unless result[:service_consumers_attributes]
      end
    end

    def strong_install_new_app_params
      params.require(:install_new_app).permit(
        :install_metadata,
        :app_label, :app_icon_url, :repository_url, :library_id, :label,
        :container_name, :host_name, :domain_name, :http_protocol,
        :install_form_comment,
        :icon_url, :license_label, :license_sourceurl, :custom_install,
        :memory, :required_memory, :recommended_memory,
        :country, :language, :deployment_type,
        :license_accept, :domains_collection, :reserved_fqdns,
        :reserved_container_names,
        service_consumers_attributes: [
          :type_path, :label, :description,
          :existing_services_collection, :orphan_services_collection,
          :create_type, :existing_service, :orphan_service,
          fields_attributes: Field.form_attributes ],
        environment_variables_attributes: [
          fields_attributes: Field.form_attributes ] )
    end

    private

    def install_repository_params
      { repository_url: params[:repository_url] , library_id: params[:library_id] , install_metadata: params.require(:install_metadata).permit!.to_h }
    end

    def redirect_path
      @repository.library_id.present? ?
        install_library_path( engines_system_id: @engines_system.id,
                                 library_id: @repository.library_id ) :
        system_control_panel_path(engines_system_id: @engines_system.id)
    end

  end
end
