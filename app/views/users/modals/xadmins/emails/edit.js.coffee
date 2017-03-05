$('.modal').modal 'hide'
$('body').append '<%= j(modal(render('form'), header: {text: 'Admin password', icon: 'fa-lock'}, id: 'edit_system_admin_password_modal') ) %>'
$('#edit_system_admin_password_modal').modal(backdrop: 'static').modal 'show'
$('#edit_system_admin_password_modal').on 'hidden.bs.modal', -> $(this).remove()
