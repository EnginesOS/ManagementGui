module EnginesSystemCore
  class CoreApp

    # include Actions
    # include Inspections
    # include Properties
    include CoreApi::ApiCall

    def initialize(api_url, token, name)
      @api_url = api_url
      @token = token
      @name = name
    end
    attr_reader :name

    # detail

    def container
      get "containers/engine/#{name}", parse: :json
    end

    def container_processes
      get "containers/engine/#{name}/ps", parse: :json
    # rescue
    #   # dummy data
    #   {
    #     "Processes": [["this","is","dummy","data","","","","","","",""], ["22673","4473","0.0","0.0","100340","768","?","Ss","Oct28","0:00","/bin/bash /home/start.bash"],["22673","4928","0.0","0.0","100376","804","?","S","Oct28","0:00","/bin/bash /home/engines/scripts/custom_start.sh"],["22673","4932","0.0","1.8","774028","37244","?","Sl","Oct28","0:00","npm"],["22673","4939","0.0","0.0","4512","84","?","S","Oct28","0:00","sh -c node index"],["22673","4940","0.0","7.1","986584","146084","?","Sl","Oct28","0:26","node index"]],
    #     "Titles": ["USER","PID","%CPU","%MEM","VSZ","RSS","TTY","STAT","START","TIME","COMMAND"]
    #   }
    end

    def blueprint
      get "containers/engine/#{name}/blueprint", parse: :json
    end

    def build_report
      get "containers/engine/#{name}/build_report", parse: :string
    end

    # state

    def state
      get "containers/engine/#{name}/state", parse: :string
    end

    def status
      get "containers/engine/#{name}/status", parse: :string
    end

    # websites

    def websites
      get "containers/engine/#{name}/websites", parse: :json
      # ['somesite.example.example', 'anothersite.example.example']
    end

    # instructions

    def stop
      get "containers/engine/#{name}/stop", parse: :boolean
    end

    def start
      get "containers/engine/#{name}/start", parse: :boolean
    end

    def pause
      get "containers/engine/#{name}/pause", parse: :boolean
    end

    def unpause
      get "containers/engine/#{name}/unpause", parse: :boolean
    end

    def restart
      get "containers/engine/#{name}/restart", parse: :boolean
    end

    def create
      get "containers/engine/#{name}/create", parse: :boolean
    end

    def recreate
      get "containers/engine/#{name}/recreate", parse: :boolean
    end

    def destroy
      delete "containers/engine/#{name}/destroy", parse: :boolean
    end

    def reinstall
      get "containers/engine/#{name}/reinstall", parse: :boolean
    end

    def uninstall(params={})
      delete "containers/engine/#{name}/delete/#{params[:remove_data] ? 'all' : 'none'}", parse: :boolean
    end

    # properties

    def set_runtime_properties(params)
      post "containers/engine/#{name}/properties/runtime", params, parse: :boolean
    end

    def set_network_properties(params)
      post "containers/engine/#{name}/properties/network", params, parse: :boolean
    end

    # services

    def persistent_services
      get "containers/engine/#{name}/services/persistent/", parse: :json
    end

    def persistent_services_for_publisher_type_path(publisher_type_path)
      get "containers/engine/#{name}/services/persistent/#{publisher_type_path}", parse: :json
    end

    def non_persistent_services
      get "containers/engine/#{name}/services/non_persistent/", parse: :json
    end

    def non_persistent_services_for_publisher_type_path(publisher_type_path)
      get "containers/engine/#{name}/services/non_persistent/#{publisher_type_path}", parse: :json
    end

    def available_services
      get "service_manager/available_services/managed_engine/#{name}", parse: :json
    end

    def update_persistent_service_consumer(params)
      post "containers/engine/#{name}/service/persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}", { variables: params[:variables] }, parse: :boolean
    # rescue
    #   return [true,false].sample if Rails.env.development?
    #   raise
    end

    def update_non_persistent_service_consumer(params)
      post "containers/engine/#{name}/service/non_persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}", { variables: params[:variables] }, parse: :boolean
    end

    def update_persistent_service_consumer_share(params)
      post "containers/engine/#{name}/service/persistent/shared/#{params[:parent_engine]}/#{params[:publisher_type_path]}/#{params[:service_handle]}", { variables: params[:variables] }, parse: :boolean
    # rescue
    #   return [true,false].sample if Rails.env.development?
    #   raise
    end

    def register_non_persistent_service_consumer(params)
      get "containers/engine/#{name}/service/non_persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}/register", parse: :boolean
    end

    def reregister_non_persistent_service_consumer(params)
      get "containers/engine/#{name}/service/non_persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}/reregister", parse: :boolean
    end

    def deregister_non_persistent_service_consumer(params)
      get "containers/engine/#{name}/service/non_persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}/deregister", parse: :boolean
    end

    def remove_persistent_service_consumer(params)
      delete "containers/engine/#{name}/services/persistent/#{params[:remove_data] ? 'all' : 'none'}/#{params[:publisher_type_path]}/#{params[:service_handle]}", parse: :boolean
    # rescue
    #   return [true,false].sample if Rails.env.development?
    #   raise
    end

    def remove_non_persistent_service_consumer(params)
      delete "containers/engine/#{name}/services/non_persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}", parse: :boolean
    # rescue
    #   return [true,false].sample if Rails.env.development?
    #   raise
    end

    def remove_persistent_service_consumer_share(params)
      delete "containers/engine/#{name}/services/persistent/shared/#{params[:parent_engine]}/#{params[:publisher_type_path]}/#{params[:service_handle]}", parse: :boolean
    # rescue
    #   return [true,false].sample if Rails.env.development?
    #   raise
    end


    def create_persistent_service_consumer(params)
      post "containers/engine/#{name}/services/persistent/#{params[:publisher_type_path]}", { variables: params[:variables] }, parse: :boolean
    # rescue
    #   return [true,false].sample if Rails.env.development?
    #   raise
    end

    def create_persistent_service_consumer_share(params)
      post "containers/engine/#{name}/services/persistent/share/#{params[:parent_engine]}/#{params[:publisher_type_path]}/#{params[:service_handle]}", { variables: params[:variables] }, parse: :boolean
    end

    def create_persistent_service_consumer_orphan(params)
      post "containers/engine/#{name}/services/persistent/orphan/#{params[:parent_engine]}/#{params[:publisher_type_path]}/#{params[:service_handle]}", { variables: params[:variables] }, parse: :boolean
    end

    def create_non_persistent_service_consumer(params)
      post "containers/engine/#{name}/services/non_persistent/#{params[:publisher_type_path]}/", { variables: params[:variables] }, parse: :boolean
    end

    # persistent services import/export

    def persistent_service_consumer_export(params)
      get "containers/engine/#{name}/service/persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}/export", parse: :string
    end

    def persistent_service_consumer_import(params)
      post "containers/engine/#{name}/service/persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}/#{params[:write]}",
        {}, { parse: :boolean }, params[:data_file]
    # rescue
    #   !true
    end

    # resolve string

    def resolve_string(string)
      post "containers/engine/#{name}/template", {template_string: string}, parse: :string
    end

    # actions

    def actionators
      get "containers/engine/#{name}/actions/", parse: :json
    end

    def actionator_for(actionator_name)
      get "containers/engine/#{name}/action/#{actionator_name}", parse: :json
    end

    def perform_actionator_for(actionator_name, params)
      post "containers/engine/#{name}/action/#{actionator_name}", params, parse: :string
    end

    # logs

    def logs
      get "containers/engine/#{name}/logs", parse: :json
    end

  end
end
