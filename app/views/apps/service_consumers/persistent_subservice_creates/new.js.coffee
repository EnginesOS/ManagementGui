$('.modal').modal 'hide'
$('body').append '<%= j(render 'new') %>'
$('#remote_modal').modal(backdrop: 'static').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
