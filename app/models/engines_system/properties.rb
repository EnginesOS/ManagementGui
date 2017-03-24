class EnginesSystem
  module Properties

    # versions

    def engines_version
      @apps_version ||= core_system.engines_version
    end

    def base_system_version
      @base_system_version ||= core_system.base_system_version
    end

    # domains

    def domains
      @domains ||=
      core_system.list_domains.map(&:second).
      sort_by { |domain| domain[:domain_name] }.
      sort_by { |domain| domain[:domain_name] == 'local' ? 0 : 1 }
    end

    def domain_for(domain_name)
      core_system.load_domain domain_name: domain_name
    end

    def default_domain
      @default_domain ||= core_system.default_domain
    end

    def default_site
      @default_domain ||= core_system.default_site
    end

    # certificates

    def certificates
      @certificates ||= core_system.certificate_domain_names[:certs].sort
    end

    # container states

    def app_states
      @app_states ||= core_system.engine_states
    end

    def app_states_with_installing_app
      @app_states_with_installing_app ||= app_states.
      tap do |app_states|
        if building? && current_build_app_name.present?
          app_states[current_build_app_name.to_sym] = 'installing'
        end
      end
    end

    def service_states
      @service_states ||= core_system.service_states
    end

    # builder

    def current_build_app_name
      current_build_params[:engine_name]
    end

    def current_build_params
      @current_build_params ||= core_system.current_build_params
    end

  end
end
