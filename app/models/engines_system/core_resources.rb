class EnginesSystem
  module CoreResources

    def build_sign_in(params = {})
      build_core_resource SignIn, params
    end

    def build_connection(params = {})
      build_core_resource Connection, params
    end

    def build_password(params = {})
      build_core_resource Password, params
    end

    def build_email(params = {})
      build_core_resource Email, params
    end

    def build_domain(params = {})
      build_core_resource Domain, params
    end

    def build_default_domain(params = {})
      build_core_resource DefaultDomain, params
    end

    def build_default_site(params = {})
      build_core_resource DefaultSite, params
    end

    def build_certificate_download(params = {})
      build_core_resource Certificate::Download, params
    end

    def build_certificate_upload(params = {})
      build_core_resource Certificate::Upload, params
    end

    def build_certificate_upload_detail(params = {})
      build_core_resource Certificate::UploadDetail, params
    end

    def build_system_ca_download
      build_core_resource Certificate::DownloadCa
    end

    def build_key(params = {})
      build_core_resource Key, params
    end

    def build_activity(params = {})
      build_core_resource Activity, params
    end

    def build_registry(params = {})
      build_core_resource Registry, params
    end

    def build_service_manager(params = {})
      build_core_resource ServiceManager, params
    end

    def build_bug_report(params = {})
      build_core_resource BugReport, params
    end

    def build_shutdown(params = {})
      build_core_resource Shutdown, params
    end

    def build_new_app(params = {})
      build_core_resource ::Install::NewApp, params
    end

    # def build_installer_repository(params = {})
    #   build_core_resource Installer::Repository, params
    # end

    private

    def build_core_resource(klass, params={})
      params = params.to_h.merge!({ engines_system: self })
      klass.new params
    end






    # def apps
    #   @apps ||=
    #   begin
    #     core_system.engine_states.map do |name, state|
    #       App.where(name: name).first_or_create.tap{ |app| app.state = state }
    #     end.sort_by &:name
    #   rescue => e
    #     raise
    #   end
    # end
    #
    # def services
    #   @services ||=
    #   begin
    #     core_system.service_states.map do |name, state|
    #       Service.where(name: name).first_or_create.tap{ |service| service.state = state }
    #     end.sort_by &:name
    #   rescue => e
    #     Rails.logger.warn "Failed to get 'services states' from Engines System API. #{e}"
    #     raise
    #   end
    # end




  end
end
