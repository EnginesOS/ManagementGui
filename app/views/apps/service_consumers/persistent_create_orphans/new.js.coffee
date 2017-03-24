$('.modal').modal 'hide'
$('body').append '<%= j(render 'apps/service_consumers/persistent_orphan_creates/new') %>'
$('#remote_modal').modal(backdrop: 'static').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
