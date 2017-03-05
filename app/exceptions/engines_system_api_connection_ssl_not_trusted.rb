class EnginesSystemApiConnectionSslNotTrusted < EnginesSystemApiError

  def to_s
    "The security certificate for the requested resource is not trusted."
  end

end
