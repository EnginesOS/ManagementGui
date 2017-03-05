$('.modal').modal 'hide'
$('body').append '<%= j(render 'edit') %>'
$('#edit_system_domain_modal').modal(backdrop: 'static').modal 'show'
$('#edit_system_domain_modal').on 'hidden.bs.modal', -> $(this).remove()
