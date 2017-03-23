var installProgressBarWidth;
var EnginesSystemBuilderEventsListener;


function listen_to_engines_builder_event_stream(engines_system_build_log_stream_url, engines_system_id, app_name){
    reset_engines_system_builder_events_listener(
      engines_system_build_log_stream_url,
      "engines_builder_event",
      function(event) { install_process_builder_event(event, engines_system_id, app_name); });
};

var install_process_builder_event = function(event, engines_system_id, app_name) {
  console.log('Builder event received: ' + event.data);
  event_data = JSON.parse(event.data);
  console.log('Builder event parsed: ' + JSON.stringify(event_data));
  switch(event_data.type) {
    case "log_line":
      install_process_builder_log_line(event_data.line);
      break;
    case "log_eof":
      install_process_builder_log_eof(engines_system_id, app_name);
      break;
    default:
      alert('Unhandled builder event: ' + JSON.stringify(event_data.data));
  };
};

// Increment the progress bar and add log line to page
var install_process_builder_log_line = function(new_line) {
  console.log('Builder event append: ' + new_line);
  installProgressBarWidth = installProgressBarWidth + 1;
  if ( installProgressBarWidth > 900 ) { installProgressBarWidth = 500 };
  install_update_progress_bar();
  if ( new_line != '.' ) {
    var new_html = ansi_up.ansi_to_html(new_line);
    $("#install_builder_log").prepend(new_html + '\n');
  };
};

// Close log listener and load build_complete
var install_process_builder_log_eof = function(engines_system_id, app_name) {
  EnginesSystemBuilderEventsListener.close();
  remote_get('install/build_complete?engines_system_id=' + engines_system_id + '&app_name=' + app_name);
};

// Update the progress bar
var install_update_progress_bar = function() {
  $('#install_builder_progress_bar').find('.progress-bar').css('width', (installProgressBarWidth/10).toString() + '%')
};

//
var reset_engines_system_builder_events_listener = function(sourceUrl, eventType, func) {
  if (EnginesSystemBuilderEventsListener) {
    console.log('Remove existing Engines builder listener ' + eventType);
    EnginesSystemBuilderEventsListener.close();
  };
  installProgressBarWidth = 0;
  console.log('Add Engines builder listener ' + eventType);
  EnginesSystemBuilderEventsListener = new EventSource(sourceUrl);
  EnginesSystemBuilderEventsListener.addEventListener(eventType, func);
}
