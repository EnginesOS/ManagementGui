$('.modal').modal 'hide'
$('body').append '<%= j(modal(render('form'), header: {text: "Connection for #{@engines_system.label}", icon: 'fa-hdd-o'}) ) %>'
$('#remote_modal').modal(backdrop: 'static').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
