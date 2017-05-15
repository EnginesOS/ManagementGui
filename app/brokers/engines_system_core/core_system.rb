module EnginesSystemCore
  class CoreSystem

    # include Actions
    # include Loaders
    # include Properties

    include Admin
    include Authentications
    include Certificates
    include Configs
    include ContainerStates
    include DefaultSites
    include DomainNames
    include EventStreams
    include InstallApps
    include Keys
    include Localization
    include Logs
    include Registries
    include Reserved
    include Restarts
    include ServiceManager
    include Statistics
    include Status
    include Updates
    include Versions
    include CoreApi::ApiCall
    include CoreApi::ApiStream

    def initialize(api_url, token, name)
      @api_url = api_url
      @token = token
      @name = name
    end

  end
end
