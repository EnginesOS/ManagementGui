module Domains
  module LinksHelper

    def edit_system_domain_link(engines_system, domain)
      edit_resource_link domain,
      url: edit_system_domain_path(engines_system_id: engines_system.id,
      engines_system_core_resources_domain:
            { domain_name: domain[:domain_name] }),
      form_class: 'display_inline pull_right_wide_media',
      text: 'Edit', icon: 'fa-edit', title: "Edit #{domain[:domain_name]}"
    end

    def delete_system_domain_link(engines_system, domain)
      destroy_resource_link domain,
      url: system_domain_path(
        engines_system_id: engines_system.id,
        engines_system_core_resources_domain:
            { domain_name: domain[:domain_name] }),
      form_class: 'display_inline',
      text: 'Delete', icon: 'fa-trash', title: "Delete #{domain[:domain_name]}",
      confirm: {
        text: "Are you sure that you want to delete #{domain[:domain_name]}?",
        title: {text: 'Confirm delete'}
      }
    end

    def new_system_domain_link(engines_system)
      new_resource_link :system_domain, text: 'New',
      params: { engines_system_id: engines_system.id },
      form_class: 'display_inline'
    end

  end
end
