module Apps
  module LinksHelper

    def up_to_app_menu_link(app)
      content_tag :div, class: 'clearfix' do
        resource_link :app_menu, params: { app_id: @app.id },
          class: 'btn btn-lg btn_resource pull_right_wide_media',
          text: false, icon: 'fa-arrow-up', title: "Return to #{app.name} menu"
      end
    end

    def up_to_app_control_panel_link(app)
      content_tag :div, class: 'clearfix' do
        resource_link :app_control_panel, params: { app_id: @app.id },
          class: 'btn btn-lg btn_resource pull_right_wide_media',
          text: false, icon: 'fa-arrow-up', title: "Return to #{app.name} control panel"
      end
    end

    def up_to_app_service_consumers_link(app)
      content_tag :div, class: 'clearfix' do
        resource_link :app_service_consumers, params: { app_id: @app.id },
          class: 'btn btn-lg btn_resource pull_right_wide_media',
          text: false, icon: 'fa-arrow-up', title: "Return to #{app.name} services"
      end
    end

    def up_to_app_service_consumer_persistent_link(persistent_service_consumer)
      content_tag :div, class: 'clearfix' do
        resource_link :app_service_consumer_persistent, params: {
            app_id: persistent_service_consumer.app.id,
            publisher_type_path: persistent_service_consumer.publisher_type_path,
            service_handle: persistent_service_consumer.service_handle },
          class: 'btn btn-lg btn_resource pull_right_wide_media',
          text: false, icon: 'fa-arrow-up', title: "Return to #{persistent_service_consumer.label} for #{persistent_service_consumer.app.name}"
      end
    end

    def up_to_app_service_consumer_persistent_subservices_link(persistent_service_consumer)
      content_tag :div, class: 'clearfix' do
        resource_link :app_service_consumer_persistent_subservices, params: {
            app_id: persistent_service_consumer.app.id,
            publisher_type_path: persistent_service_consumer.publisher_type_path,
            service_handle: persistent_service_consumer.service_handle },
          class: 'btn btn-lg btn_resource pull_right_wide_media',
          text: false, icon: 'fa-arrow-up', title: "Return to new Subservice on #{persistent_service_consumer.label} for #{persistent_service_consumer.app.name}"
      end
    end

    def up_to_app_environment_link(app)
      content_tag :div, class: 'clearfix' do
        resource_link :app_environment, params: { app_id: @app.id },
          class: 'btn btn-lg btn_resource pull_right_wide_media',
          text: false, icon: 'fa-arrow-up', title: "Return to #{app.name} services"
      end
    end

    def up_to_app_actions_link(app)
      content_tag :div, class: 'clearfix' do
        resource_link :app_actions, params: { app_id: @app.id },
          class: 'btn btn-lg btn_resource pull_right_wide_media',
          text: false, icon: 'fa-arrow-up', title: "Return to #{app.name} actions"
      end
    end

    # def new_app_service_connection_link(app)
    #   resource_link :new_app_service, params: { app_id: app.id },
    #   text: 'New', icon: 'fa-plus-square-o', title: 'New service connection for #{app.name}'
    # end

  end
end
