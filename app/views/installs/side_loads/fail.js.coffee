$("#system_menu_modal_flash_messages").html("<%= j(flash_message :alert, 'Failed to shutdown machine.') %>");
$("#system_menu_modal_flash_messages").hide().fadeIn();
