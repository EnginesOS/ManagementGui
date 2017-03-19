class EnginesSystemApiResourceNotFoundError < EnginesSystemApiError

  def initialize(error)
    @error = error
  end

  def system_error_message
    @system_error_message ||= JSON.parse(@error.response, symbolize_names: true)[:error_object][:error_mesg]
  rescue JSON::ParserError
    @system_error_message =
      "The resource did not return valid response. This could be because the URL for the Engines system has been entered incorrectly."
  end

  def to_s
    "Failed to find the requested resource. (#{system_error_message})"
  end

  def flash_message_params
    { type: :alert, message: to_s }
  end

  def system_url
    uri = URI.parse( @error.response.request.url )
    "#{uri.scheme}://#{uri.host}"
  end

end
