module EnginesSystemCore
  class CoreApp

    include CoreApi::ApiCall

    def initialize(api_url, token, name)
      @api_url = api_url
      @token = token
      @name = name
    end

    attr_reader :name

    # detail

    def container
      get "containers/engine/#{name}", expect: :json
    end

    def container_processes
      get "containers/engine/#{name}/ps", expect: :json
    end

    def blueprint
      get "containers/engine/#{name}/blueprint", expect: :json
    end

    def build_report
      get "containers/engine/#{name}/build_report", expect: :plain_text
    end

    # state

    def state
      get "containers/engine/#{name}/state", expect: :plain_text
    end

    def status
      get "containers/engine/#{name}/status", expect: :json
    end

    # websites

    def websites
      get "containers/engine/#{name}/websites", expect: :json
      # ['somesite.example.example', 'anothersite.example.example']
    end

    # instructions

    def stop
      get "containers/engine/#{name}/stop", expect: :boolean
    end

    def start
      get "containers/engine/#{name}/start", expect: :boolean
    end

    def pause
      get "containers/engine/#{name}/pause", expect: :boolean
    end

    def unpause
      get "containers/engine/#{name}/unpause", expect: :boolean
    end

    def restart
      get "containers/engine/#{name}/restart", expect: :boolean
    end

    def create
      get "containers/engine/#{name}/create", expect: :boolean
    end

    def recreate
      get "containers/engine/#{name}/recreate", expect: :boolean
    end

    def destroy
      delete "containers/engine/#{name}/destroy", expect: :boolean
    end

    def reinstall
      get "containers/engine/#{name}/reinstall", expect: :boolean
    end

    def uninstall(params={})
      delete "containers/engine/#{name}/delete/#{params[:remove_data] ? 'all' : 'none'}", expect: :boolean
    end

    # properties

    def set_runtime_properties(params)
      post "containers/engine/#{name}/properties/runtime", params: params, expect: :boolean
    end

    def set_network_properties(params)
      post "containers/engine/#{name}/properties/network", params: params, expect: :boolean
    end

    # services

    def persistent_services
      get "containers/engine/#{name}/services/persistent/", expect: :json
    end

    def persistent_services_for_publisher_type_path(publisher_type_path)
      get "containers/engine/#{name}/services/persistent/#{publisher_type_path}", expect: :json
    end

    def non_persistent_services
      get "containers/engine/#{name}/services/non_persistent/", expect: :json
    end

    def non_persistent_services_for_publisher_type_path(publisher_type_path)
      get "containers/engine/#{name}/services/non_persistent/#{publisher_type_path}", expect: :json
    end

    def available_services
      get "service_manager/available_services/managed_engine/#{name}", expect: :json
    end

    def available_subservices_for(publisher_type_path)
      publisher_namespace, type_path = publisher_type_path.split('/', 2)
      get "service_manager/available_services/type/#{type_path}", expect: :json
    end

    def create_persistent_service_consumer_subservice_consumer(params)
      publisher_namespace, type_path = params[:publisher_type_path].split('/', 2)
      post "containers/service/#{params[:service_name]}/sub_services/#{name}/#{params[:parent_service_handle]}",
        { publisher_namespace: publisher_namespace,
          type_path: type_path,
          variables: params[:variables] }, expect: :boolean
    end


    def update_persistent_service_consumer(params)
      post "containers/engine/#{name}/service/persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}", params: { variables: params[:variables] }, expect: :boolean
    end

    def update_non_persistent_service_consumer(params)
      post "containers/engine/#{name}/service/non_persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}", params: { variables: params[:variables] }, expect: :boolean
    end

    def update_persistent_service_consumer_share(params)
      post "containers/engine/#{name}/service/persistent/shared/#{params[:parent_engine]}/#{params[:publisher_type_path]}/#{params[:service_handle]}", params: { variables: params[:variables] }, expect: :boolean
    end

    def register_non_persistent_service_consumer(params)
      get "containers/engine/#{name}/service/non_persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}/register", expect: :boolean
    end

    def reregister_non_persistent_service_consumer(params)
      get "containers/engine/#{name}/service/non_persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}/reregister", expect: :boolean
    end

    def deregister_non_persistent_service_consumer(params)
      get "containers/engine/#{name}/service/non_persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}/deregister", expect: :boolean
    end

    def remove_persistent_service_consumer(params)
      delete "containers/engine/#{name}/services/persistent/#{params[:remove_data] ? 'all' : 'none'}/#{params[:publisher_type_path]}/#{params[:service_handle]}", expect: :boolean
    end

    def remove_non_persistent_service_consumer(params)
      delete "containers/engine/#{name}/services/non_persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}", expect: :boolean
    end

    def remove_persistent_service_consumer_share(params)
      delete "containers/engine/#{name}/services/persistent/shared/#{params[:parent_engine]}/#{params[:publisher_type_path]}/#{params[:service_handle]}", expect: :boolean
    end


    def create_persistent_service_consumer(params)
      post "containers/engine/#{name}/services/persistent/#{params[:publisher_type_path]}", params: { variables: params[:variables] }, expect: :boolean
    end

    def create_persistent_service_consumer_share(params)
      post "containers/engine/#{name}/services/persistent/share/#{params[:parent_engine]}/#{params[:publisher_type_path]}/#{params[:service_handle]}", params: { variables: params[:variables] }, expect: :boolean
    end

    def create_persistent_service_consumer_orphan(params)
      post "containers/engine/#{name}/services/persistent/orphan/#{params[:parent_engine]}/#{params[:publisher_type_path]}/#{params[:service_handle]}", params: { variables: params[:variables] }, expect: :boolean
    end

    def create_non_persistent_service_consumer(params)
      post "containers/engine/#{name}/services/non_persistent/#{params[:publisher_type_path]}/", params: { variables: params[:variables] }, expect: :boolean
    end

    # persistent services import/export

    def persistent_service_consumer_export(params)
      get "containers/engine/#{name}/service/persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}/export", expect: :file
    end

    def persistent_service_consumer_import(params)
      post "containers/engine/#{name}/service/persistent/#{params[:publisher_type_path]}/#{params[:service_handle]}/#{params[:write]}",
        { expect: :boolean }, params[:data_file]
    end

    # resolve string

    def resolve_string(string)
      post "containers/engine/#{name}/template", params: {template_string: string}, expect: :plain_text
    end

    # actions

    def actionators
      get "containers/engine/#{name}/actions/", expect: :json
    end

    def actionator_for(actionator_name)
      get "containers/engine/#{name}/action/#{actionator_name}", expect: :json
    end

    def perform_actionator_for(actionator_name, params, return_type)
      post "containers/engine/#{name}/action/#{actionator_name}", params: params, expect: return_type.to_sym
    end

    # logs

    def logs
      get "containers/engine/#{name}/logs", expect: :json
    end

    #memory

    def memory_metrics
      get "containers/engine/#{name}/metrics/memory", expect: :json
    end

    #network

    def network_metrics
      get "containers/engine/#{name}/metrics/network", expect: :json
    end

  end
end
