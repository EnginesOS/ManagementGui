$('.modal').modal 'hide'
$('body').append '<%= j(render 'apps/menus/show') %>'
$('#<%= @app.id %>_menu_modal').modal 'show'
$('#<%= @app.id %>_menu_modal').on 'hidden.bs.modal', -> $(this).remove()
$("#<%= @app.id %>_menu_modal_flash_messages").html("<%= j(flash_messages) %>");
$("#<%= @app.id %>_menu_modal_flash_messages").hide().fadeIn();
