$('.modal').modal 'hide'
$('body').append '<%= j(render "installs/builds/show") %>'
$('#remote_modal').modal 'show'
$('#remote_modal').on 'hidden.bs.modal', -> $(this).remove()
$('#remote_modal_flash_messages').html('<%= j(flash_messages) %>');
$('#remote_modal_flash_messages').hide().fadeIn();
SubcribeToBuildLogChannel(<%= @app.engines_system.id %>, '<%= @app.name %>');
