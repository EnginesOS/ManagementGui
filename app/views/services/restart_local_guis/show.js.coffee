$('.modal').modal 'hide'
$('body').append '<%= j render('show') %>'
$('#wait_for_local_system_modal').modal 'show'
$('#wait_for_local_system_modal').on 'hidden.bs.modal', -> $(this).remove()
local_system_busy_polling(<%= @service.engines_system.id %>, '<%= system_busy_path(engines_system_id: @service.engines_system.id) %>', '<%= cloud_path(cloud_id: @service.engines_system.cloud.id) %>')
