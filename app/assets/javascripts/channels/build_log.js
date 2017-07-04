var SubcribeToBuildLogChannel = function(engines_system_id, app_name) {

    if ( typeof App.build_log_channel_subscription !== 'undefined') {
      App.cable.subscriptions.remove(App.build_log_channel_subscription);
    };
    App.build_log_channel_subscription = App.cable.subscriptions.create(
      { channel: "BuildLogChannel", engines_system_id: engines_system_id },
      {
        connected: function() {
        },
        disconnected: function() {
        },
        received: function(message_string) {
          message = JSON.parse(message_string);
          switch(message.type) {
            case "log_line":
              install_process_builder_log_line(message.line);
              break;
            case "log_eof":
              App.cable.subscriptions.remove(App.build_log_channel_subscription);
              install_process_builder_log_eof(engines_system_id, app_name);
              break;
            default:
              alert_modal('Build log error', 'Unhandled build log channel message: ' + message_text);
          };
        }
      }
    );
};

var installProgressBarWidth = 0;

// Increment the progress bar and add log line to page
var install_process_builder_log_line = function(new_line) {
  console.log('Builder event append: ' + new_line);
  installProgressBarWidth = installProgressBarWidth + 1;
  if ( installProgressBarWidth > 900 ) { installProgressBarWidth = 500 };
  install_update_progress_bar();
  if ((new_line == '.') && ($("#install_builder_log").text().charAt(0) == '.')) {
    $("#install_builder_log").prepend(new_line);
  } else {
    var new_html = ansi_up.ansi_to_html(new_line);
    $("#install_builder_log").prepend(new_html + '\n');
  };
};

var install_process_builder_log_eof = function(engines_system_id, app_name) {
  remote_get('install/build_complete?engines_system_id=' + engines_system_id + '&app_name=' + app_name, true);
};

var install_update_progress_bar = function() {
  console.log(installProgressBarWidth);
  $('#install_builder_progress_bar').find('.progress-bar').css('width', (installProgressBarWidth/10).toString() + '%');
};
