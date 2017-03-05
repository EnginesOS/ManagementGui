class EnginesRepositoryUrlError < EnginesRepositoryError

  def to_s
    'Could not find the blueprint.'
  end

end
