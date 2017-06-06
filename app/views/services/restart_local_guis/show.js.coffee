$('.modal').modal 'hide'
$('body').append '<%= j render('show') %>'
$('#wait_for_local_system_modal').modal 'show'
$('#wait_for_local_system_modal').on 'hidden.bs.modal', -> $(this).remove()
local_system_busy_polling()
