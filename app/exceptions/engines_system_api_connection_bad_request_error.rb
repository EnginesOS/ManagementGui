class EnginesSystemApiConnectionBadRequestError < EnginesSystemApiError

  def initialize(error)
    @error = error
  end

  def system_error
    @system_error ||=
      JSON.parse(@error.response, symbolize_names: true)
  end

  def to_s
    "The connection to the Engines system received an invalid request. (#{system_error[:error_object][:error_mesg]})"
  rescue
    "The connection to the Engines system received an invalid request. (No response from system.)"
  end

  def detail
    system_error
  end

  def flash_message_params
    { type: :alert, message: to_s }
  end

end
