module Systems
  module ModalsHelper

    def system_menu_modal(engines_system)
      modal(header: {text: "System", icon: 'fa-hdd-o'}, footer_close: true) do
          system_menu_system_details(engines_system) +
          (content_tag :hr if engines_system.needs.any?) +
          content_tag(:span, class: 'engines_system_status') do
            icon_text('fa-warning', engines_system.needs.join(' - ')) if engines_system.needs.any?
          end +
          content_tag(:hr) +
          system_update_link(engines_system) +
          system_install_link(engines_system) +
          # system_installer_link(engines_system) +
          system_restart_base_os_link(engines_system) +
          content_tag(:hr) +
          system_control_panel_link(engines_system)
      end
    end

    def system_update_modal(engines_system)
      modal(header: {text: "System update", icon: 'fa-refresh'}, footer_close: true) do
        up_to_system_menu_link(engines_system) +
        content_tag(:div, class: "engines_system_status") do
          icon_text('fa-warning', engines_system.needs.join(' - ')) if engines_system.needs.any?
        end +
        content_tag(:hr) +
        content_tag(:div) do
          content_tag(:span, "Engines #{engines_system.engines_version}", class: 'dropdown-header') +
          system_update_engines_link(engines_system)
        end + content_tag(:hr) +
        content_tag(:div) do
          content_tag(:span, "#{engines_system.base_system_version[:name]} #{engines_system.base_system_version[:version]}", class: 'dropdown-header') +
          system_update_base_os_link(engines_system)
        end
      end
    end

    def system_control_panel_modal(engines_system)
      modal(
      header: {text: "Control panel for #{engines_system.label}", icon: 'fa-cogs'},
      footer_close: true ) do
        up_to_system_menu_link(engines_system) +
        system_locale_link(engines_system) +
        system_timezone_link(engines_system) +
        content_tag(:hr) +
        system_domains_link(engines_system) +
        system_certificates_link(engines_system) +
        system_key_menu_link(engines_system) +
        content_tag(:hr) +
        system_default_site_link(engines_system) +
        content_tag(:hr) +
        system_admin_link(engines_system) +
        content_tag(:hr) +
        system_last_install_link(engines_system) +
        installer_side_load_link(engines_system) +
        content_tag(:hr) +
        system_registry_link(engines_system) +
        system_service_manager_link(engines_system) +
        content_tag(:hr) +
        system_activity_link(engines_system) +
        system_logs_link(engines_system) +
        system_bugs_link(engines_system) +
        system_report_link(engines_system) +
        content_tag(:hr) +
        system_restart_engines_link(engines_system) +
        system_shutdown_link(engines_system)
      end
    end

    def system_key_menu_modal(engines_system)
      modal(header: {text: 'SSH key', icon: 'fa-key'}, footer_close: true) do
          up_to_system_control_panel_link(engines_system) +
          system_key_generate_link(engines_system) +
          system_key_upload_link(engines_system) +
          system_key_download_link(engines_system)
      end
    end

    def system_connection_status_modal(engines_system)
      modal(header: {text: "System connection", icon: 'fa-wifi'}, footer_close: true, id: "system_#{engines_system.id}_connection_status_modal") do
        content_tag :div, class: 'text-center' do
          content_tag(:strong, 'System API') + ' ' + content_tag(:span, Rails.application.config.engines_system_core_url)
        end
      end
    end


  end
end
