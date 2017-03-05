class EnginesSystemApiConnectionRefusedError < EnginesSystemApiError

  def to_s
    "Failed to connect with the Engines system."
  end

end
