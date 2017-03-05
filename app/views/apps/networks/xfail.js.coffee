$("#app_<%= @app_network.app.id %>_network_modal").html("<%= j(flash_message :alert, "Failed to update network settings for #{@app_network.app.name}.") %>");
$("#app_<%= @app_network.app.id %>_network_modal").hide().fadeIn();
