$('.modal').modal 'hide'
$('body').append '<%= j(modal(render('form'), header: {text: "Admin password for #{@engines_system.label}", icon: 'fa-lock'}) ) %>'
$('#remote_modal').modal(backdrop: 'static').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
