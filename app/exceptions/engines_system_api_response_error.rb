class EnginesSystemApiResponseError < EnginesSystemApiError

  def initialize(error)
    @error = error
  end

  def to_s
    "Failed to process the response from the Engines system. #{@error.to_s}"
  rescue
    "Failed to process the response from the Engines system. (Failed to generate error message.)"
  end

end
