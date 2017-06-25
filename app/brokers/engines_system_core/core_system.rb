module EnginesSystemCore
  class CoreSystem

    include CoreApi::ApiCall
    include CoreApi::ApiStream
    include EventStreams

    def initialize(system_url, token, name)
      @system_url = system_url
      @token = token
      @name = name
    end

    # admin

    def update_password(params)
      return false
      # post "system/users/", params: params.merge({ user_name: 'admin', token: @token }), expect: :boolean
    end

    def update_email(params)
      return false
      # post "system/users/", params: { email: params[:email], current_password: params[:password], user_name: 'admin', token: @token }, expect: :boolean
    end

    def admin_user
      return {email: "call GET /v0/system/users/ when James says it's ready"}
      # get "system/users/", params: { user_name: 'admin', token: @token }, expect: :json
    end

    # authentication

    def authenticate(password)
      post "system/login", params: { user_name: 'admin', password: password }, expect: :plain_text
    end

    # certificates

    def certificate_domain_names
      get 'system/certs/', expect: :json
    end

    def certificate_file(domain_name)
      get "system/certs/#{domain_name}", expect: :file
    end

    def delete_certificate(domain_name)
      delete "system/certs/#{domain_name}", expect: :boolean
    end

    def save_domain_certificate(domain_name, certificate, key, password=nil)
      post 'system/certs/', params: {domain_name: domain_name, certificate: certificate, key: key, password: password}, expect: :boolean
    end

    def save_default_certificate(certificate, key, password=nil)
      post 'system/certs/default', params: {certificate: certificate, key: key, password: password}, expect: :boolean
    end

    def system_ca
      get "system/certs/system_ca", expect: :file
    end

    # configs

    def remote_exception_logging?
      get 'system/config/remote_exception_logging', expect: :boolean
    end

    def enable_remote_exception_logging
      post 'system/config/remote_exception_logging/enable', expect: :boolean
    end

    def disable_remote_exception_logging
      post 'system/config/remote_exception_logging/disable', expect: :boolean
    end

    # container statuses

    def engine_statuses
      get 'containers/engines/status', expect: :json
    end

    def service_statuses
      get 'containers/services/status', expect: :json
    end

    # default site

    def default_site
      get 'system/config/default_site', expect: :plain_text
    end

    def update_default_site(params)
      post 'system/config/default_site', params: params, expect: :boolean
    end

    # domain names

    def list_domains
      get 'system/domains/', expect: :json
    end

    def default_domain
      get 'system/config/default_domain', expect: :plain_text
    end

    def update_default_domain(params)
      post 'system/config/default_domain', params: params, expect: :boolean
    end

    def load_domain(params)
      get "system/domains/#{params[:domain_name]}", expect: :json
    end

    def update_domain(params)
      post "system/domains/#{params[:domain_name]}", params: params, expect: :boolean
    end

    def add_domain(params)
      post 'system/domains/domain_name', params: params, expect: :boolean
    end

    def remove_domain(domain_name)
      delete "system/domains/#{domain_name}", expect: :boolean
    end

    # install apps

    def build_app(params)
      post 'containers/engines/build', params: params, expect: :boolean
    end

    def current_build_params
      get 'engine_builder/params', expect: :json
    end

    def last_build_params
      get 'engine_builder/last_build/params', expect: :json
    end

    def last_build_log
      get 'engine_builder/last_build/log', expect: :plain_text
    end

    # keys

    def key_file
      get 'system/keys/user/engines', expect: :file
    end

    def save_key(key)
      post 'system/keys/user/engines', params: { public_key: key }, expect: :boolean
    end

    def generate_key
      get 'system/keys/user/engines/generate', expect: :plain_text
    end

    # localization

    def timezone
      get 'system/control/base_os/timezone', expect: :plain_text
    end

    def set_timezone(timezone)
      timezone = ActiveSupport::TimeZone.find_tzinfo(timezone).to_s.sub(' - ', '/')
      post 'system/control/base_os/timezone', params: {timezone: timezone}, expect: :boolean
    end

    def locale
      get 'system/control/base_os/locale', expect: :json
    end

    def set_locale(lang_code, country_code)
      post 'system/control/base_os/locale', params: {lang_code: lang_code, country_code: country_code} , expect: :boolean
    end

    # logs

    def logs
      { stdout: 'Logs are not available.', stderr: 'Logs are not available.' }
    end

    # registries

    def registry_configurations
      get 'registry/configurations/', expect: :json
    end

    def registry_apps
      get 'registry/engines/', expect: :json
    end

    def registry_services
      get 'registry/services/', expect: :json
    end

    def registry_orphans
      get 'registry/orphans/', expect: :json
    end

    def registry_shares
      get 'registry/shares/', expect: :json
    end

    # reserved

    def reserved_container_names
      get 'system/reserved/engine_names', expect: :json
    end

    def reserved_fqdns
      get 'system/reserved/hostnames', expect: :json
    end

    def reserved_ports
      get 'system/reserved/ports', expect: :json
    end

    # restarts

    def restart_engines
      get 'system/control/engines_system/restart', expect: :boolean
    end

    def restart_base_os
      get 'system/control/base_os/restart', expect: :boolean
    end

    def shutdown(params)
      post 'system/control/base_os/shutdown', params: params, expect: :boolean
    end

    # service manager

    def service_definition_for(publisher_type_path)
      get "service_manager/service_definitions/#{publisher_type_path}", expect: :json
    end

    def persistent_service_connections_for(publisher_type_path)
      get "service_manager/persistent_services/#{publisher_type_path}", expect: :json
    end

    def orphan_service_connections_for(publisher_type_path)
      get "service_manager/orphan_services/#{publisher_type_path}", expect: :json
    end

    def orphan_service_consumers
      get 'service_manager/orphan_services/', expect: :json
    end

    def delete_orphan_service_consumer(params)
      delete "service_manager/orphan_service/#{params[:type_path]}/#{params[:parent_engine]}/#{params[:service_handle]}", expect: :boolean
    end

    # statistics

    def container_memory_statistics
      get 'system/metrics/memory/statistics', expect: :json
    end

    def system_memory_statistics
      get 'system/metrics/memory', expect: :json
    end

    def cpu_statistics
      get 'system/metrics/load', expect: :json
    end

    def disk_statistics
      get 'system/metrics/disks', expect: :json
    end

    def network_statistics
      get 'system/metrics/network', expect: :json
    end

    # status

    def builder_status
      get 'engine_builder/status', expect: :json
    end

    def system_status
      get 'system/status', expect: :json
    end

    def system_update_status
      get 'system/status/update', expect: :json
    end

    def first_run_required?
      get 'system/status/first_run_required', expect: :boolean
    end

    # updates

    def update_engines
      get 'system/control/engines_system/update', expect: :boolean
      # false
    end

    def update_base_os
      get 'system/control/base_os/update', expect: :boolean
      # true
    end

    # versions

    def engines_version
      get 'system/version/system', expect: :plain_text
    end

    def base_system_version
      get 'system/version/base_os', expect: :json
    end

  end
end
