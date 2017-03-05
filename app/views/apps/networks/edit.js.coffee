$('.modal').modal 'hide'
$('body').append '<%= j render('edit') %>'
$("#remote_modal").modal(backdrop: 'static').modal 'show'
$("#remote_modal").on 'hidden.bs.modal', -> $(this).remove()
