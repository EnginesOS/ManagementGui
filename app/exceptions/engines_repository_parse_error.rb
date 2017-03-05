class EnginesRepositoryParseError < EnginesRepositoryError

  def to_s
    'The repository did not return a valid blueprint.'
  end

end
