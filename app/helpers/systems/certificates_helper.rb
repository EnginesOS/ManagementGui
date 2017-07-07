module Systems
  module CertificatesHelper

    def new_system_certificate_link(engines_system)
      resource_link :new_system_certificates_upload_certificate,
      params: { engines_system_id: engines_system.id },
      text: 'Upload new certificate', icon: 'fa-upload', title: 'Upload new certificate', form_class: 'display_inline'
    end

    def edit_system_certificates_service_link(engines_system, service_name)
      resource_link :edit_system_certificates_service,
      params: { engines_system_id: engines_system.id, service_name: service_name },
      text: service_name, icon: 'fa-caret-right', title: 'Assign certificate', form_class: 'display_inline'
    end

    def system_ca_link(engines_system)
      resource_link :system_certificates_download_ca,
      params: { engines_system_id: engines_system.id }, remote: false, spinner: false,
      text: 'Download CA', icon: 'fa-download', title: 'Download system CA', form_class: ''
    end

    def download_system_certificate_link(engines_system, certificate_path)
      resource_link :system_certificates_download,
      params: { engines_system_id: engines_system.id, certificate_path: certificate_path }, remote: false, spinner: false,
      text: 'Download', icon: 'fa-download', title: 'Download certificate', form_class: 'display_inline'
    end

    def destroy_system_certificate_link(engines_system, certificate_path)
      destroy_resource_link :system_certificates_destroy,
      params: { engines_system_id: engines_system.id, certificate_path: certificate_path },
      text: 'Delete', title: 'Delete certificate from system', form_class: 'display_inline pull_right_wide_media'
    end

  end
end
