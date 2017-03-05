class EnginesSystemApiConnectionSslInvalid < EnginesSystemApiError

  def to_s
    "The security certificate is invalid."
  end

end
