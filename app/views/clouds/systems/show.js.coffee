$("#engines_system_<%= @engines_system.id %>").html '<%= j(render "show") %>'
$("#engines_system_<%= @engines_system.id %>_flash_messages").hide();
$("#engines_system_<%= @engines_system.id %>_flash_messages").fadeIn();
<% if !Rails.env.development? || Rails.application.config.run_event_stream %>
listen_to_engines_system_event_stream("<%= system_events_stream_path(engines_system_id: @engines_system.id) %>", "<%= @engines_system.id %>", "<%= @engines_system.label %>")
<% end %>
