class EnginesErrorError < EnginesError

  def initialize(error)
    @error = error
  end

  def to_s
    "Failed to handle Engines error. (#{@error.to_s})"
  rescue
    "Failed to handle Engines error."
  end

  def backtrace
    @error.backtrace
  rescue
    [ 'Failed to generate backtrace.' ]
  end

end
