App.engines_system_view_update_channel_subscriptions = [];

var SubcribeToEnginesSystemViewUpdateChannel = function(engines_system_id) {

  if ( typeof App.engines_system_view_update_channel_subscriptions[engines_system_id] === 'undefined') {
    App.engines_system_view_update_channel_subscriptions[engines_system_id] = App.cable.subscriptions.create(
      { channel: "EnginesSystemViewUpdateChannel", engines_system_id: engines_system_id },
      {
        connected: function() {
          console.log('Connected to EnginesSystemViewUpdateChannel');
        },
        disconnected: function() {
          App.engines_system_view_update_channel_subscriptions = App.engines_system_view_update_channel_subscriptions.splice(engines_system_id,1)
          console.log('Disconnected from EnginesSystemViewUpdateChannel');
        },
        received: function(message_object) {
          console.log('Received on EnginesSystemViewUpdateChannel: ' + JSON.stringify(message_object));
          $('#engines_system_' + engines_system_id).html(message_object.html)
        }
      }
    );
  };

};
