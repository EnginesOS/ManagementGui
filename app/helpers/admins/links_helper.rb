module Admins
  module LinksHelper

    def edit_system_admin_password_link(engines_system)
      edit_resource_link :system_admin_password, params: { engines_system_id: engines_system.id },
      text: 'Password', icon: 'fa-lock', title: 'Change admin user password'
    end

    def edit_system_admin_email_link(engines_system)
      edit_resource_link :system_admin_email, params: { engines_system_id: engines_system.id },
      text: 'Email', icon: 'fa-envelope', title: 'Change admin user email address'
    end

  end
end
