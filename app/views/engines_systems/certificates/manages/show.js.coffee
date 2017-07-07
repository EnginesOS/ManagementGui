$('.modal').modal 'hide'
$('body').append '<%= j(render "engines_systems/certificates/manages/show") %>'
$('#remote_modal').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
$("#remote_modal_flash_messages").html("<%= j(flash_messages) %>");
$("#remote_modal_flash_messages").hide().fadeIn();
