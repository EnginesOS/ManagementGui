module EnginesSystemCore
  class CoreService

    # include Actions
    # # include Definitions
    # include Inspections
    # include Properties
    include CoreApi::ApiCall

    def initialize(api_url, token, name)
      @api_url = api_url
      @token = token
      @name = name
    end
    attr_reader :name

    def container
      get "containers/service/#{name}", expect: :json
    end

    def container_processes
      get "containers/service/#{name}/ps", expect: :json
    end

    #  state

    def state
      get "containers/service/#{name}/state", expect: :string
    end

    def status
      get "containers/service/#{name}/status", expect: :json
    end

    #  websites

    def websites
      get "containers/service/#{name}/websites", expect: :json
    end

    #  instructions

    def stop
      get "containers/service/#{name}/stop", expect: :boolean
    end

    def start
      get "containers/service/#{name}/start", expect: :boolean
    end

    def pause
      get "containers/service/#{name}/pause", expect: :boolean
    end

    def unpause
      get "containers/service/#{name}/unpause", expect: :boolean
    end

    def restart
      get "containers/service/#{name}/restart", expect: :boolean
    end

    def create
      get "containers/service/#{name}/create", expect: :boolean
    end

    def recreate
      get "containers/service/#{name}/recreate", expect: :boolean
    end

    def destroy
      delete "containers/service/#{name}/destroy", expect: :boolean
    end

    def rebuild
      delete "containers/service/#{name}/delete", expect: :boolean
    end

    # configurations

    def configurations
      get "containers/service/#{name}/configurations/", expect: :json
    end

    def update_configuration(configurator_name, params={})
      post "containers/service/#{name}/configuration/#{configurator_name}", params: params, expect: :boolean
    end

    # consumers

    def consumers
      get "containers/service/#{name}/consumers/", expect: :json
    end

    def consumers_for(application_name)
      get "containers/service/#{name}/consumers/#{application_name}", expect: :json
    end

    # consumed services

    def consumed_persistent_services
      get "containers/service/#{name}/services/persistent/", expect: :json
    end

    def consumed_non_persistent_services
      get "containers/service/#{name}/services/non_persistent/", expect: :json
    end

    # actions

    def actionators
      get "containers/service/#{name}/actions/", expect: :json
    end

    def actionator_for(actionator_name)
      get "containers/service/#{name}/action/#{actionator_name}", expect: :json
    end

    def perform_actionator_for(actionator_name, params)
      post "containers/service/#{name}/action/#{actionator_name}", params, expect: :string
    end

    # properties

    def set_runtime_properties(params)
      post "containers/service/#{name}/properties/runtime", params: params, expect: :boolean
    end
    #
    #      def set_network_properties(params)
    #        post "containers/service/#{name}/properties/network", params, expect: :boolean
    #      end
    #
    #  #resolve string
    #
    #      def resolve_string(string)
    #        post "containers/service/#{name}/template", {template_string: string}, expect: :string
    #      end

    # logs

    def logs
      get "containers/service/#{name}/logs", expect: :json
    end

  end
end
