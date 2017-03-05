$('.modal').modal 'hide'
$('body').append '<%= j(render "new") %>'
$('#remote_modal').modal(backdrop: 'static').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
$("#remote_modal_flash_messages").html("<%= j(flash_messages) %>")
$("#remote_modal_flash_messages").hide().fadeIn()

$('#install_custom_install_button').click ->
  $('#install_custom_install_button').hide()
  $('.install_custom_install_settings').show()
  $('#install_new_app_custom_install').val 'true'
  return
  
