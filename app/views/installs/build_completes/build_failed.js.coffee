$('#install_builder_progress_bar').hide();
$('#remote_modal_flash_messages').html('<%= j(flash_messages) %>');
$('#remote_modal_flash_messages').hide().fadeIn();
remote_get('cloud/system?engines_system_id=<%= @engines_system.id %>');
