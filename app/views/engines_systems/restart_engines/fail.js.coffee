$("#system_menu_modal_flash_messages").html("<%= j(flash_message :alert, 'Failed to restart Engines.') %>");
$("#system_menu_modal_flash_messages").hide().fadeIn();
