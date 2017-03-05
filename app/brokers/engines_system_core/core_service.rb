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

    #  detail

    def container
      get "containers/service/#{name}", parse: :json
    end

    def container_processes
      get "containers/service/#{name}/ps", parse: :json
    # rescue
    #   # dummy data
    #   {
    #     "Processes": [["this","is","dummy","data","","","","","","",""], ["22673","4473","0.0","0.0","100340","768","?","Ss","Oct28","0:00","/bin/bash /home/start.bash"],["22673","4928","0.0","0.0","100376","804","?","S","Oct28","0:00","/bin/bash /home/engines/scripts/custom_start.sh"],["22673","4932","0.0","1.8","774028","37244","?","Sl","Oct28","0:00","npm"],["22673","4939","0.0","0.0","4512","84","?","S","Oct28","0:00","sh -c node index"],["22673","4940","0.0","7.1","986584","146084","?","Sl","Oct28","0:26","node index"]],
    #     "Titles": ["USER","PID","%CPU","%MEM","VSZ","RSS","TTY","STAT","START","TIME","COMMAND"]
    #   }
    end


    #  state

    def state
      get "containers/service/#{name}/state", parse: :string
    end

    def status
      get "containers/service/#{name}/status", parse: :string
    end

    #  websites

    def websites
      get "containers/service/#{name}/websites", parse: :json
    end

    #  instructions

    def stop
      get "containers/service/#{name}/stop", parse: :boolean
    end

    def start
      get "containers/service/#{name}/start", parse: :boolean
    end

    def pause
      get "containers/service/#{name}/pause", parse: :boolean
    end

    def unpause
      get "containers/service/#{name}/unpause", parse: :boolean
    end

    def restart
      get "containers/service/#{name}/restart", parse: :boolean
    end

    def create
      get "containers/service/#{name}/create", parse: :boolean
    end

    def recreate
      get "containers/service/#{name}/recreate", parse: :boolean
    end

    def destroy
      delete "containers/service/#{name}/destroy", parse: :boolean
    end

    def rebuild
      delete "containers/service/#{name}/delete", parse: :boolean
    end

    # configurations

    def configurations
      get "containers/service/#{name}/configurations/", parse: :json
    end

    def update_configuration(configurator_name, params={})
      post "containers/service/#{name}/configuration/#{configurator_name}", params, parse: :boolean
    end

    # consumers

    def consumers_for(application_name)
      get "containers/service/#{name}/consumers/#{application_name}", parse: :json
    end

    # actions

    # def actionators
    #   get "containers/service/#{name}/actions/", parse: :json
    # end

    # properties

    def set_runtime_properties(params)
      post "containers/service/#{name}/properties/runtime", params, parse: :boolean
    end
    #
    #      def set_network_properties(params)
    #        post "containers/service/#{name}/properties/network", params, parse: :boolean
    #      end
    #
    #  #resolve string
    #
    #      def resolve_string(string)
    #        post "containers/service/#{name}/template", {template_string: string}, parse: :string
    #      end

    # logs

    def logs
      get "containers/service/#{name}/logs", parse: :json
    end

  end
end
