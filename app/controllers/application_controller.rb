class ApplicationController < ActionController::Base

  rescue_from Exception, with: :handle_exception

  protect_from_forgery with: :reset_session

  before_action :authenticate

  # Resource setters

  def set_cloud
    @cloud = current_user.user_profile.clouds.find(params[:cloud_id])
  rescue ActiveRecord::RecordNotFound
    raise EnginesError.new "Failed to find cloud."
  end

  def set_engines_system
    @engines_system = current_user.user_profile.engines_systems.find(params[:engines_system_id])
  rescue ActiveRecord::RecordNotFound
    raise EnginesError.new "Failed to find Engines system."
  end

  def set_app
    @app = current_user.user_profile.apps.find(params[:app_id])
  rescue ActiveRecord::RecordNotFound
    raise EnginesError.new "Failed to find app."
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

  def handle_exception(error)
    Rails.logger.warn "Handling exception (#{error.class})..."
    return handle_event_stream_error(error) if request.format == "text/event-stream"
    error = error.cause if error.is_a?(ActionView::Template::Error)
    return handle_engines_error(error) if error.is_a?(EnginesError) || error.is_a?(EnginesError::ApiConnectionError) || error.is_a?(EnginesError::ApiConnectionAuthenticationError)
    handle_fatal_error(error)
  end

  def handle_event_stream_error(error)
    Rails.logger.warn "Engines event stream error"
    Rails.logger.warn error.class
    Rails.logger.warn error.to_s
    log_error_backtrace_for(error)
    render plain: {type: "error"}.to_json, status: 200
  end

  def handle_engines_error(error)
    Rails.logger.warn "Engines error"
    Rails.logger.warn error.class
    Rails.logger.warn error.to_s
    @error = error
    respond_to do |format|
      format.js{ error_render error, 'exceptions/engines_errors/show', status: 200 }
      format.html{ error_render error, 'exceptions/engines_errors/show', status: 200, layout: false }
    end
  end

  def handle_fatal_error(error)
    Rails.logger.warn "Fatal error"
    Rails.logger.warn error.class
    Rails.logger.warn error.to_s
    log_error_backtrace_for(error)
    @bug_report = BugReport.new self, error
    respond_to do |format|
      format.js{ error_render error, 'exceptions/fatal_errors/show', status: 200 }
      format.html{ error_render error, 'exceptions/fatal_errors/show', status: 200 }
    end
  end

  def error_render(error, partial, opts)
    p "RENDER ERROR ****************************************************************************"
    if response_body
      Rails.logger.warn "============================\n#{partial}\n#{opts}\n#{status}\n#{error}\nresponse body #{response_body}\n=============================================="
      status = opts[:status]
      response_body = [ ( render_to_string partial, layout: opts[:layout] ) ]
    else
      status = opts[:status]
      render partial, opts
    end
  end

  def log_error_backtrace_for(error)
    error.backtrace.each { |line| Rails.logger.warn line }
  end

end
