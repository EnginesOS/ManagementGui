$('.modal').modal 'hide'
$('body').append '<%= j(render 'new') %>'
$('#new_cloud_modal').modal(backdrop: 'static').modal 'show'
$('#new_cloud_modal').on 'hidden.bs.modal', -> $(this).remove()
