class EnginesLibraryResponseError < EnginesLibraryError

  def to_s
    'There was an error processing the response from the library.'
  end

end
