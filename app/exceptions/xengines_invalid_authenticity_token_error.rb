class EnginesInvalidAuthenticityTokenError < EnginesError

  def to_s
    'The authenticity token has changed and needs to be refreshed. The page will be reload.'
  end

end
