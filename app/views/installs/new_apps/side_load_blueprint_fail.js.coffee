$('#wait_for_system_modal').modal 'hide'
hide_waiting_spinner()
$('body').append '<%= j(render "engines_systems/control_panels/show") %>'
$('#remote_modal').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
$("#remote_modal_flash_messages").html("<%= j(flash_messages) %>")
$("#remote_modal_flash_messages").hide().fadeIn()
