class EnginesSystemApiResponseError < EnginesSystemApiError

  def initialize(name, error)
    @name = name
    @error = error
  end

  # def system_error
  #   @system_error ||=
  #     JSON.parse(@error.response, symbolize_names: true)[:error_object]
  # end

  def to_s
    "Failed to process the response from the Engines system. #{@error.to_s}"
  end

end

#
#
# def to_s
#   "The Engines system failed to find the requested resource. (#{system_error[:error_mesg]})"
# end
#
# def detail
#   system_error
# end
#
# def flash_message_params
#   { type: (system_error[:error_type] == 'warning' ? :alert : :error ), message: system_error[:error_mesg] }
# end
