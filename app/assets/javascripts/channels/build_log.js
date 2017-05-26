var SubcribeToBuildLogChannel = function(engines_system_id, app_name) {

    if ( typeof App.build_log_channel_subscription !== 'undefined') {
      App.cable.subscriptions.remove(App.build_log_channel_subscription);
    };
    var client_id = (new Date()).getTime();
    App.build_log_channel_subscription = App.cable.subscriptions.create(
      { channel: "BuildLogChannel", engines_system_id: engines_system_id, client_id: client_id },
      {
        connected: function() {
          // console.log('Connected to BuildLogChannel');
        },
        disconnected: function() {
          // console.log('Disconnected from BuildLogChannel');
        },
        received: function(message_string) {
          // console.log('Received on BuildLogChannel: ' + message_string);
          message = JSON.parse(message_string);
          // console.log('Builder event parsed: ' + JSON.stringify(message));
          switch(message.type) {
            case "log_line":
              install_process_builder_log_line(message.line);
              break;
            case "log_eof":
              App.cable.subscriptions.remove(App.build_log_channel_subscription);
              install_process_builder_log_eof(engines_system_id, app_name);
              break;
            default:
              alert('Build log error. Unhandled build log channel message: ' + message_text);
          };
        }
      }
    );

};
