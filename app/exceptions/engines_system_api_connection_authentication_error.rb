class EnginesSystemApiConnectionAuthenticationError < EnginesSystemApiError

  # attr_accessor :url
  #
  # def initialize(url)
  #   @url = url
  # end
  #
  # def engines_system
  #   @engines_system ||= EnginesSystem.find_by(url: @url)
  # end
  #
  # def to_s
  #   "The connection to #{engines_system.label} (#{@url}) could not be authenticated. Please click on 'Authenticate connection' and enter the admin password for the Engines system."
  # end

  def to_s
    "Failed to authenticate the connection with the Engines system."
  end

end
