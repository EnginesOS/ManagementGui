$('.modal').modal 'hide'
$('body').append '<%= j(render 'engines_systems/domains/index') %>'
$('#remote_modal').modal(backdrop: 'static').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
$("#remote_modal_flash_messages").html("<%= j(flash_messages) %>");
$("#remote_modal_flash_messages").hide().fadeIn();
