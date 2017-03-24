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
      form_class: 'display_inline pull_right_wide_media'
    end

    def delete_system_local_domain_link(engines_system)
      destroy_resource_link :local_domain,
      url: system_domain_path(
        engines_system_id: engines_system.id,
        engines_system_core_resources_domain:
            { domain_name: :local }),
      form_class: 'display_inline pull_right_wide_media',
      text: 'Disable', icon: 'fa-toggle-on', title: "Disable Avahi zeroconf",
      confirm: false
    end

    def create_system_local_domain_link(engines_system)
      resource_link :local_domain,
      url: system_domain_path(
        engines_system_id: engines_system.id,
        engines_system_core_resources_domain:
            { domain_name: :local }),
      method: :post,
      form_class: 'display_inline pull_right_wide_media',
      text: 'Enable', icon: 'fa-toggle-off', title: "Enable Avahi zeroconf"

# "engines_system_core_resources_domain"=>{"domain_name"=>"local", "internal_only"=>"0", "self_hosted"=>"0"}, "button"=>"", "engines_system_id"=>"32"}


    end

  end
end
