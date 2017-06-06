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

    def app_statuses
      @app_statuses ||= core_system.engine_statuses
    end

    def app_statuses_with_installing_app
      @app_statuses_with_installing_app ||= app_statuses.
      tap do |app_statuses|
        if building? && current_build_app_name.present?
          app_statuses[current_build_app_name.to_sym] = { state: 'installing' }
        end
      end
    end

    def service_statuses
      @service_statuses ||= core_system.service_statuses
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
