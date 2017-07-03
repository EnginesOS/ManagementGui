module Systems
  module LinksHelper

    def system_menu_link(engines_system, opts={})
      button_to system_menu_path(engines_system_id: engines_system.id),
      method: :get,
      title: "#{engines_system.label} menu",
      class: 'btn btn-lg btn_resource show_waiting_spinner', remote: true do
        system_connection_status(engines_system, opts) + ' ' + engines_system.label
      end
    end

    def system_connection_menu_link(engines_system, opts={})
      button_to system_connection_menu_path(engines_system_id: engines_system.id),
      method: :get,
      title: "#{engines_system.label} connection menu",
      class: 'btn btn-lg btn_resource show_waiting_spinner', remote: true do
        system_connection_status(engines_system, opts) + ' ' + engines_system.label
      end
    end

    def system_sign_in_link(engines_system, opts={})
      content_tag :div, class: 'clearfix text-center' do
        resource_link :new_system_sign_in,
        params: {engines_system_id: engines_system.id},
        text: 'Authenticate', icon: 'fa-key',
        title: "Authenticate connection to #{engines_system.label}"
      end
    end

    def edit_system_connection_link(engines_system, opts={})
      button_to edit_system_connection_path(engines_system_id: engines_system.id),
      method: :get,
      title: "Edit connection for #{engines_system.label}",
      class: 'btn btn-lg btn_resource', remote: true do
        icon_text 'fa-edit', 'Edit connection'
      end
    end

    def system_reload_link(engines_system, opts={})
      content_tag :div, class: 'clearfix text-center' do
        resource_link :cloud_system,
        params: {engines_system_id: engines_system.id},
        text: 'Connect', icon: 'fa-wifi',
        disable_with: "Connecting #{engines_system.url}",
        spinner: false,
        title: "Establish connection to #{engines_system.label}"
      end
    end

    def up_to_system_menu_link(engines_system)
      content_tag :div, class: 'clearfix' do
        resource_link :system_menu,
        params: {engines_system_id: engines_system.id},
        class: 'btn btn-lg btn_resource pull_right_wide_media',
        text: false, icon: 'fa-arrow-up ',
        title: "Return to #{engines_system.label} menu"
      end
    end

    def up_to_install_libraries_or_system_menu_link(engines_system)
      if @engines_system.cloud.libraries.count == 1
        resource = :system_menu
      else
        resource = :install_libraries_menu
      end
      content_tag :div, class: 'clearfix' do
        resource_link resource,
        params: {engines_system_id: engines_system.id},
        class: 'btn btn-lg btn_resource pull_right_wide_media',
        text: false, icon: 'fa-arrow-up ',
        title: "Return to #{engines_system.label} menu"
      end
    end

    def up_to_system_control_panel_link(engines_system)
      content_tag :div, class: 'clearfix' do
        resource_link :system_control_panel,
        params: {engines_system_id: engines_system.id},
        text: false, icon: 'fa-arrow-up',
        title: 'Return to system control panel',
        class: 'pull_right_wide_media'
      end
    end

    # def system_services_link(engines_system)
    #   resource_link :system_services,
    #   params: {engines_system_id: engines_system.id},
    #   text: 'Services', icon: 'fa-compass', remote: false,
    #   title: 'System services'
    # end

    def system_update_link(engines_system)
      resource_link :system_update,
      params: {engines_system_id: engines_system.id},
      text: 'Update', icon: 'fa-refresh', title: 'System update menu'
    end

    def system_control_panel_link(engines_system)
      resource_link :system_control_panel,
      params: {engines_system_id: engines_system.id},
      text: 'Control panel', icon: 'fa-cogs', title: 'Control panel menu'
    end

    def system_key_menu_link(engines_system)
      resource_link :system_keys,
      params: {engines_system_id: engines_system.id},
      text: 'SSH key', icon: 'fa-key', title: 'Upload/download key'
    end

    def system_installer_link(engines_system)
      resource_link :installer_precheck,
      params: {engines_system_id: engines_system.id},
      text: 'Install app (old code)', icon: 'fa-plus-square', title: 'Install an app'
    end

    def system_install_link(engines_system)
      resource_link :install_precheck,
      params: {engines_system_id: engines_system.id},
      text: 'Install app', icon: 'fa-plus-square', title: 'Install an app'
    end

    def installer_side_load_link(engines_system)
      resource_link :new_install_side_load,
      params: {engines_system_id: engines_system.id},
      text: 'Side load', icon: 'fa-caret-square-o-right',
      title: 'Side load an app directly from repository URL'
    end

    def system_service_manager_link(engines_system)
      resource_link :system_service_manager,
      params: {engines_system_id: engines_system.id},
      text: 'Service manager', icon: 'fa-compass', title: 'Service manager'
    end

    def system_activity_link(engines_system)
      resource_link :system_activity,
      params: {engines_system_id: engines_system.id},
      text: 'Activity', icon: 'fa-bar-chart', title: 'Monitor system activity'
    end

    def system_properties_link(engines_system)
      resource_link :edit_system_properties,
      params: {engines_system_id: engines_system.id},
      text: 'Display', icon: 'fa-tv', title: 'System properties'
    end

    def system_last_install_link(engines_system)
      resource_link :system_last_install,
      params: {engines_system_id: engines_system.id},
      text: 'Last install', icon: 'fa-history',
      title: 'Review last app installation'
    end

    def system_timezone_link(engines_system)
      resource_link :edit_system_timezone,
      params: {engines_system_id: engines_system.id},
      text: 'Timezone', icon: 'fa-clock-o', title: 'Timezone settings'
    end

    def system_locale_link(engines_system)
      resource_link :edit_system_locale,
      params: {engines_system_id: engines_system.id},
      text: 'Locale', icon: 'fa-map-marker', title: 'Locale settings'
    end

    def system_bugs_link(engines_system)
      resource_link :edit_system_bug_reports,
      params: {engines_system_id: engines_system.id},
      text: 'Bugs', icon: 'fa-bug', title: 'Bug report settings'
    end

    def system_report_link(engines_system)
      resource_link :system_report,
      params: {engines_system_id: engines_system.id},
      text: 'Report', icon: 'fa-stethoscope', title: 'System report'
    end

    def system_domains_link(engines_system)
      resource_link :system_domains,
      params: {engines_system_id: engines_system.id},
      text: 'Domains', icon: 'fa-globe', title: 'Manage domains'
    end

    def system_default_site_link(engines_system)
      resource_link :edit_system_default_site,
      params: {engines_system_id: engines_system.id},
      text: 'Default site',
      icon: 'fa-home',
      title: 'Set the default site'
    end

    def system_default_domain_link(engines_system)
      resource_link :edit_system_default_domain,
      params: {engines_system_id: engines_system.id},
      text: 'Edit',
      icon: 'fa-edit',
      title: 'Set the default domain',
      form_class: 'display_inline pull_right_wide_media'
    end

    def system_certificates_link(engines_system)
      resource_link :system_certificates,
      params: {engines_system_id: engines_system.id},
      text: 'Certificates', icon: 'fa-certificate', title: 'Certificate'
    end

    def system_admin_link(engines_system)
      resource_link :system_admin,
      params: {engines_system_id: engines_system.id},
      text: 'System admin', icon: 'fa-user', title: 'Admin user profile'
    end

    def system_key_generate_link(engines_system)
      resource_link :system_key_generate,
      params: {engines_system_id: engines_system.id},
      remote: false, spinner: false,
      text: 'Generate private', icon: 'fa-user-secret',
      title: 'Generate new SSH private key for system'
    end

    def system_key_upload_link(engines_system)
      resource_link :new_system_key_upload,
      params: {engines_system_id: engines_system.id},
      text: 'Upload public', icon: 'fa-upload',
      title: 'Upload new system key'
    end

    def system_key_download_link(engines_system)
      resource_link :system_key_download, remote: false, spinner: false,
      params: {engines_system_id: engines_system.id},
      text: 'Download public', icon: 'fa-download',
      title: 'Download system key'
    end

    def system_logs_link(engines_system)
      resource_link :system_logs,
      params: {engines_system_id: engines_system.id},
      text: 'Logs', icon: 'fa-file-text-o', title: 'View system logs'
    end

    def system_registry_link(engines_system)
      resource_link :system_registry,
      params: {engines_system_id: engines_system.id},
      text: 'Registry', icon: 'fa-arrows', title: 'Manage system registry'
    end

    def system_restart_base_os_link(engines_system)
      destroy_resource_link :system_restart_base_os,
      params: {engines_system_id: engines_system.id},
      method: :get, url: system_restart_base_os_path,
      text: 'Reboot', icon: 'fa-power-off', title: "Reboot system",
      confirm: {text: "Are you sure that you want to reboot the system?",
                title: {text: 'Confirm reboot'},
                submit_text: 'Reboot',
                disabled_text: 'Submitting' }
    end

    def system_restart_engines_link(engines_system)
      destroy_resource_link :system_restart_engines,
      params: {engines_system_id: engines_system.id},
      method: :get, url: system_restart_engines_path,
      text: 'Warm restart', icon: 'fa-recycle', title: 'Restart Engines without rebooting the base system',
      confirm: {text: 'Are you sure that you want to restart Engines?',
                title: {text: 'Confirm restart'},
                submit_text: 'Restart',
                disabled_text: 'Submitting' }
    end

    def system_shutdown_link(engines_system)
      destroy_resource_link :system_shutdown,
      params: {engines_system_id: engines_system.id},
      method: :get, url: new_system_shutdown_path,
      text: 'Shutdown', icon: 'fa-plug', title: 'Shutdown system',
      confirm: false
    end

    def system_update_engines_link(engines_system)
      resource_link :system_update_engines,
      params: {engines_system_id: engines_system.id},
      text: 'Update Engines', title: 'Update Engines', icon: 'fa-refresh'
    end

    def system_update_base_os_link(engines_system)
      resource_link :system_update_base_os,
      params: {engines_system_id: engines_system.id},
      text: 'Update base OS', title: 'Update base OS', icon: 'fa-refresh'
    end

  end
end
