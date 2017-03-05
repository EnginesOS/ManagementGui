$('.modal').modal 'hide'
$('body').append '<%= j(modal(render('form'), header: {text: "#{@user.username} email", icon: 'fa-lock'}) ) %>'
$('#remote_modal').modal(backdrop: 'static').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
