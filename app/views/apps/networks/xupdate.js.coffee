$(".modal").modal('hide');
$("body").append("<%= j render('apps/control_panels/show', app: @app_network.app ) %>");
$("#app_<%= @app_network.app.id %>_menu_modal").modal("show");
$('#app_<%= @app_network.app.id %>_menu_modal').on 'hidden.bs.modal', -> $(this).remove()
$("#app_<%= @app_network.app.id %>_menu_modal_flash_messages").html("<%= j(flash_message :notice, "Memory settings for #{@app_network.app.name} were successfully updated.") %>");
$("#app_<%= @app_network.app.id %>_menu_modal_flash_messages").hide().fadeIn();
