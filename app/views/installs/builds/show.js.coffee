$('.modal').modal 'hide'
$('body').append '<%= j(render "installs/builds/show") %>'
$('#remote_modal').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
$('#remote_modal_flash_messages').html('<%= j(flash_messages) %>');
$('#remote_modal_flash_messages').hide().fadeIn();
listen_to_engines_builder_event_stream('<%= install_build_log_path(engines_system_id: @app.engines_system.id) %>', '<%= @app.engines_system.id %>', '<%= @app.name %>');
