module Services
  module LinksHelper

    def up_to_service_menu_link(service)
      content_tag :div, class: 'clearfix' do
        resource_link :service_menu, params: { service_id: @service.id },
          class: 'btn btn-lg btn_resource pull_right_wide_media',
          text: false, icon: 'fa-arrow-up ', title: "Return to #{service.name} menu"
      end
    end

    def up_to_service_control_panel_link(service)
      content_tag :div, class: 'clearfix' do
        resource_link :service_control_panel, params: { service_id: @service.id },
          class: 'btn btn-lg btn_resource pull_right_wide_media',
          text: false, icon: 'fa-arrow-up', title: "Return to #{service.name} control panel"
      end
    end

    def up_to_service_actions_link(service)
      content_tag :div, class: 'clearfix' do
        resource_link :service_actions, params: { service_id: @service.id },
          class: 'btn btn-lg btn_resource pull_right_wide_media',
          text: false, icon: 'fa-arrow-up', title: "Return to #{service.name} actions"
      end
    end

  end
end
