$('.modal').modal 'hide'
$('body').append '<%= j(render "services/abouts/show") %>'
$('#remote_modal').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
