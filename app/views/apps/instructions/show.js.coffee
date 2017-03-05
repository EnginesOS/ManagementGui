$("#container_<%= @app.name %>_menu_modal_flash_messages").hide().html("<%= j(flash_message @action_result[:type], @action_result[:message]) %>").fadeIn();
