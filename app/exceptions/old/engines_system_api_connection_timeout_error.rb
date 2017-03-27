class EnginesSystemApiConnectionTimeoutError < EnginesSystemApiError

  def to_s
    "The connection to the Engines system timed-out."
  end

end
