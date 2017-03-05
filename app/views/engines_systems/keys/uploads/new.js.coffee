$('.modal').modal 'hide'
$('body').append '<%= j(render 'new') %>'
$('#new_system_key_upload_modal').modal(backdrop: 'static').modal 'show'
$('#new_system_key_upload_modal').on 'hidden.bs.modal', -> $(this).remove()
