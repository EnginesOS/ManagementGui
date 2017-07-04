$("#engines_system_<%= @service.engines_system.id %>_container_<%= @service.name %>_menu_modal_flash_messages").html("<%= j(flash_message @action_result[:type], @action_result[:message]) %>");
$("#engines_system_<%= @service.engines_system.id %>_container_<%= @service.name %>_menu_modal_flash_messages").hide().fadeIn();
