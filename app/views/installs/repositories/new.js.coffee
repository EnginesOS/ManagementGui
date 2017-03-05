$('.modal').modal 'hide'
show_wait_for_system_response_spinner()
$('body').append '<%= j render('new') %>'
$('#wait_for_system_modal').modal 'show'
$('#wait_for_system_modal').on 'hidden.bs.modal', -> $(this).remove()
remote_get("<%= new_install_new_app_path(@install_repository_params) %>");
