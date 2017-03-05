class EnginesError < StandardError;

  def to_s
    'Engines Error.'
  end

  def detail
    nil
  end

  def flash_message_params
    { type: :alert, message: to_s }
  end

end
