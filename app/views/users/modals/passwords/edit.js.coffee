$('.modal').modal 'hide'
$('body').append '<%= j(modal(render('form'), header: {text: "GUI #{@user.username} password", icon: 'fa-lock'}) ) %>'
$('#remote_modal').modal(backdrop: 'static').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
