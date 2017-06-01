$('.modal').modal 'hide'
alert '<%= flash[:notice] %>'
show_waiting_spinner()
window.location.href = '<%= new_user_session_path %>'
