$('.modal').modal 'hide'
alert '<%= flash[:notice] %>'
show_wait_for_system_response_spinner()
window.location.href = '<%= new_user_session_path %>'
