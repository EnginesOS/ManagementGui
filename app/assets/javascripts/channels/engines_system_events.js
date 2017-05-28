App.engines_system_events_channel_subscriptions = [];

var SubcribeToEnginesSystemEventsChannel = function(engines_system_id, engines_system_label) {

  if ( typeof App.engines_system_events_channel_subscriptions[engines_system_id] === 'undefined') {
    var client_id = (new Date()).getTime();
    App.engines_system_events_channel_subscriptions[engines_system_id] = App.cable.subscriptions.create(
      { channel: "EnginesSystemEventsChannel", engines_system_id: engines_system_id, client_id: client_id },
      {
        connected: function() {
          // console.log('Connected to EnginesSystemEventsChannel');
        },
        disconnected: function() {
          App.engines_system_events_channel_subscriptions = App.engines_system_events_channel_subscriptions.splice(engines_system_id,1)
          // console.log('Disconnected from EnginesSystemEventsChannel');
        },
        received: function(message_string) {
          // console.log('Received on EnginesSystemEventsChannel: ' + message_string);
          var event = JSON.parse(message_string);
          console.log('System ' + engines_system_id + ' event - ' + JSON.stringify(event));
          switch(event.type) {
            case "heartbeat":
              display_connected_system(engines_system_id, engines_system_label);
              system_status_indicator_pulse(engines_system_id);
              break;
            case "empty":
              break;
            case "error":
              close_engines_system_event_stream(engines_system_id)
              alert(event.message);
              break;
            case "timeout":
              display_disconnected_system(engines_system_id, engines_system_label);
              console.log('Timeout on API events stream ' + engines_system_label);
              break;
            case "disconnected":
              App.cable.subscriptions.remove(App.engines_system_events_channel_subscriptions[engines_system_id]);
              App.engines_system_events_channel_subscriptions = App.engines_system_events_channel_subscriptions.splice(engines_system_id,1)
              display_disconnected_system(engines_system_id, engines_system_label);
              break;
            case "update_container_state":
              update_container_status_indicators(engines_system_id, event.name, event.state)
              break;
            // case "reload_system":
            //   console.log("reload_system $$$$$$$$$$$$$$$$$$$$$$$$");
            //   remote_get('/cloud/system/?engines_system_id=' + engines_system_id);
            //   break;
            default:
              console.log('Unhandled system event from ' + engines_system_label + ': ' + JSON.stringify(event));
          };
        }
      }
    );
  };

};
