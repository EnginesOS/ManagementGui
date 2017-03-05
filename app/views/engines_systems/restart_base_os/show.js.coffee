$('.modal').modal 'hide'
$('body').append '<%= j render('show') %>'
$('#wait_for_system_modal').modal 'show'
$('#wait_for_system_modal').on 'hidden.bs.modal', -> $(this).remove()
system_busy_polling()
