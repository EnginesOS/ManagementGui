$('.modal').modal 'hide'
$('body').append '<%= j(render "apps/abouts/show") %>'
$('#remote_modal').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
