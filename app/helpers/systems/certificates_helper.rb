module Systems
  module CertificatesHelper

    def system_domain_certificate_links(engines_system)
      engines_system.certificates.to_s.html_safe +
      engines_system.certificates.map do |certificate_domain_name|
        content_tag(:hr) +
        content_tag(:div, class: 'dl-horizontal')do
          data_list_text('Certificate for', certificate_domain_name) +
          system_domain_certificate_link(engines_system, certificate_domain_name) +
          destroy_system_domain_certificate_link(engines_system, certificate_domain_name)
        end
      end.join.html_safe
    end

    def new_system_domain_certificate_link(engines_system)
      resource_link :new_system_certificate_upload,
      params: { engines_system_id: engines_system.id },
      text: 'Upload', icon: 'fa-upload', title: 'Upload new certificate', form_class: 'display_inline'
    end

    def system_ca_link(engines_system)
      resource_link :system_certificate_download_ca,
      params: { engines_system_id: engines_system.id }, remote: false, spinner: false,
      text: 'Download CA', icon: 'fa-download', title: 'Download system CA', form_class: 'display_inline pull_right_wide_media'
    end

    def system_domain_certificate_link(engines_system, domain_name)
      resource_link :system_certificate_download,
      params: { engines_system_id: engines_system.id, domain_name: domain_name }, remote: false, spinner: false,
      text: 'Download', icon: 'fa-download', title: 'Download certificate', form_class: 'display_inline'
    end

    def destroy_system_domain_certificate_link(engines_system, domain_name)
      destroy_resource_link :system_certificate_destroy,
      params: { engines_system_id: engines_system.id, domain_name: domain_name },
      text: 'Delete', title: 'Delete certificate from system', form_class: 'display_inline pull_right_wide_media'
    end

  end
end
