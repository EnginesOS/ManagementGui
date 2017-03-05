class ApplicationController < ActionController::Base

  rescue_from Exception, with: :handle_exception

  protect_from_forgery with: :reset_session

  before_action :authenticate

  # Resource setters

  def set_cloud
    @cloud = current_user.user_profile.clouds.find(params[:cloud_id])
  end

  def set_engines_system
    @engines_system = current_user.user_profile.engines_systems.find(params[:engines_system_id])
  end

  def set_app
    @app = current_user.user_profile.apps.find(params[:app_id])
  end

  def set_service
    @service = current_user.user_profile.services.find(params[:service_id])
  end

  def set_library(library_id=nil)
    @library = @engines_system.cloud.libraries.find(library_id || params[:library_id])
  end

  private

  # Auth / Devise

  def authenticate
    authenticate_user! unless controller_path == 'users/modals/sign_ins' ||
                              ( controller_path == 'clouds/portals' &&
                                params[:cloud_id].blank? )
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || admin_shortcut || user_profile_portal_path
  end

  def admin_shortcut
    if current_user.is_admin? && current_user.user_profile.clouds.count == 1
      cloud_path(cloud_id: current_user.user_profile.clouds.first.id )
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  # Error handling

  # def handle_invalid_authenticity_token
  #   raise EnginesInvalidAuthenticityTokenError
  # end

  def handle_exception(error)
    Rails.logger.warn "Handling exception (#{error.class})..."
    if request.format == "text/event-stream"
      handle_event_stream_error(error)
    elsif error.is_a?(EnginesError)
      handle_engines_error(error)
    elsif error.is_a?(ActionView::Template::Error)
      if error.cause.is_a?(EnginesError)
        handle_engines_error(error.cause)
      else
        handle_fatal_error(error.cause)
      end
    else
      handle_fatal_error(error)
    end
  end

  def handle_event_stream_error(error)
    Rails.logger.warn "Engines event stream error"
    Rails.logger.warn error.class
    Rails.logger.warn error.to_s
    output_error_backtrace_for(error)
    render plain: {type: "error"}.to_json, status: 200
  end

  def handle_engines_error(error)
    Rails.logger.debug "Engines error"
    Rails.logger.debug error.class
    Rails.logger.debug error.to_s
    @error = error
    respond_to do |format|
      format.js{ render 'exceptions/engines_errors/show', status: 200 }
      format.html{ render 'exceptions/engines_errors/show', status: 200, layout: false }
    end
  end

  def handle_fatal_error(error)
    Rails.logger.warn "Fatal error"
    Rails.logger.warn error.class
    Rails.logger.warn error.to_s
    output_error_backtrace_for(error)
    @error = error
    respond_to do |format|
      format.js{ render 'exceptions/fatal_errors/show', status: 200 }
      format.html{ render 'exceptions/fatal_errors/show', status: 200 }
    end
  end

  def output_error_backtrace_for(error)
    error.backtrace.each { |line| Rails.logger.warn line }
  end

end
