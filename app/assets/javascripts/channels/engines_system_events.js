App.engines_system_events_channel_subscriptions = [];

var SubcribeToEnginesSystemEventsChannel = function(engines_system_id, engines_system_label) {

  if ( typeof App.engines_system_events_channel_subscriptions[engines_system_id] === 'undefined') {
    App.engines_system_events_channel_subscriptions[engines_system_id] = App.cable.subscriptions.create(
      { channel: "EnginesSystemEventsChannel", engines_system_id: engines_system_id },
      {
        connected: function() {
          console.log('Connected to EnginesSystemEventsChannel' + engines_system_id);
        },
        disconnected: function() {
          console.log('Disconnected from EnginesSystemEventsChannel' + engines_system_id);
        },
        received: function(message_string) {
          console.log('Received on EnginesSystemEventsChannel' + engines_system_id + ': ' + message_string);
          var event = JSON.parse(message_string);
          console.log('System ' + engines_system_id + ' event - ' + JSON.stringify(event));
          switch(event.type) {
            case "heartbeat":
              break;
            case "empty":
              break;
            case "error":
              alert('Event stream error: ' + event.message);
              break;
            case "timeout":
              console.log('Timeout on API events stream ' + engines_system_label);
              break;
            case "disconnected":
              remote_get('cloud/system?engines_system_id=' + engines_system_id);
              break;
            case "update_container_state":
              update_container_status_indicators(engines_system_id, event.name, event.state)
              break;
            default:
              console.log('Unhandled system event from ' + engines_system_label + ': ' + JSON.stringify(event));
          };
        }
      }
    );
  };

};

var update_container_status_indicators = function(engines_system_id, app_name, state) {
  $('#engines_system_' + engines_system_id + '_container_' + app_name + '_menu_modal_flash_messages').html(
    '<div class="alert alert-info alert-dismissible"> \
      <button name="button" type="button" class="close" data-dismiss="alert"> \
        × \
      </button> \
      State changed to ' + state + '. \
    </div>'
  );
  $("#engines_system_" + engines_system_id + " ." + app_name + "_container_state, #engines_system_" + engines_system_id + "_container_" + app_name + "_menu_modal").each(function() {
    $(this).find(".container_state_indicator").hide();
    $(this).find(".container_state_indicator." + state).show();
  });
};
