// function listen_to_engines_system_event_stream(engines_system_event_stream_url, engines_system_id, engines_system_label){
//   if ( $("#system_" + engines_system_id + "_api_connection_status").hasClass("engines_system_api_connected") ) {
//     resetEnginesSystemEventsListener(
//       engines_system_id,
//       engines_system_event_stream_url,
//       "engines_system_event",
//       function(event) { process_engines_system_event(engines_system_event_stream_url, engines_system_id, engines_system_label, event.data) },
//       function(error) { process_engines_system_event_error(engines_system_event_stream_url, engines_system_id, engines_system_label, error) } );
//   };
// };

// function close_engines_system_event_stream(engines_system_id){
//   if (EnginesSystemEventsListeners[engines_system_id]) {
//     console.log('Close Engines system listener ' + engines_system_id);
//     EnginesSystemEventsListeners[engines_system_id].close();
//     EnginesSystemEventsListeners[engines_system_id] = null;
//   };
// };

// var process_engines_system_event_error = function(engines_system_event_stream_url, engines_system_id, engines_system_label, error) {
//   console.log('Events stream error from ' + engines_system_label + '(' + engines_system_event_stream_url + ') - ' + JSON.stringify(error));
//   close_engines_system_event_stream(engines_system_id);
//   alert("There was a communication error with " + engines_system_label +". Please reload the page. (Client event stream closed on error.)");
// };

// var process_engines_system_event = function(engines_system_id, engines_system_label, event_string) {
//   var event = JSON.parse(event_string);
//   console.log('System ' + engines_system_id + ' event - ' + JSON.stringify(event));
//   if ($("#engines_system_" + engines_system_id).length) {
//     switch(event.type) {
//       case "heartbeat":
//         display_connected_system(engines_system_id);
//         system_status_indicator_pulse(engines_system_id);
//         break;
//       case "empty":
//         break;
//       case "error":
//         close_engines_system_event_stream(engines_system_id)
//         alert(event.message);
//         break;
//       case "timeout":
//         display_disconnected_system(engines_system_id, engines_system_label);
//         console.log('Timeout on API events stream ' + engines_system_label);
//         break;
//       case "disconnected":
//         display_disconnected_system(engines_system_id, engines_system_label);
//         break;
//       case "update_container_state":
//         update_container_status_indicators(engines_system_id, event)
//         break;
//       case "system_events_stream_closed":
//         remote_get('/cloud/system/?engines_system_id=' + engines_system_id);
//         break;
//       default:
//         console.log('Unhandled system event from ' + engines_system_label + ': ' + JSON.stringify(event));
//     };
//   } else {
//     console.log('No system for event. Closing event stream...');
//     close_engines_system_event_stream(engines_system_id);
//   };
// };

var update_container_status_indicators = function(engines_system_id, app_name, state) {
  $('#container_' + app_name + '_menu_modal_flash_messages').html(
    '<div class="alert alert-info alert-dismissible"> \
      <button name="button" type="button" class="close" data-dismiss="alert"> \
        × \
      </button> \
      State changed to ' + state + '. \
    </div>'
  );
  $("." + app_name + "_container_state").each(function() {
    $(this).find(".container_state_indicator").hide();
    $(this).find(".container_state_indicator." + state).show();
  });
};

var system_status_indicator_pulse = function(engines_system_id) {
  animate_system_status_indicator(engines_system_id, {opacity: "0.5"});
  setTimeout(function(){ animate_system_status_indicator(engines_system_id, {opacity: "1"}); }, 500)
};

var animate_system_status_indicator = function(engines_system_id, css) {
  $("#system_" + engines_system_id + "_api_connection_status").animate(css, 500);
};

var display_disconnected_system = function(engines_system_id, engines_system_label) {
  if ($("#system_" + engines_system_id + "_api_connection_status").hasClass("engines_system_api_connected")) {
    console.log("display_disconnected_system $$$$$$$$$$$$$$$$$$$$$$$$");
    remote_get('cloud/system?engines_system_id=' + engines_system_id);
  };
};

var display_connected_system = function(engines_system_id, engines_system_label) {
  if (!$("#system_" + engines_system_id + "_api_connection_status").hasClass("engines_system_api_connected")) {
    console.log("display_connected_system $$$$$$$$$$$$$$$$$$$$$$$$");
    remote_get('cloud/system?engines_system_id=' + engines_system_id);
  };
};

// var EnginesSystemEventsListeners = {};
// var resetEnginesSystemEventsListener = function(engines_system_id, sourceUrl, eventType, func, error_func) {
//   if (EnginesSystemEventsListeners[engines_system_id]) {
//     console.log('Existing Engines system listener ' + eventType + ' - ' + sourceUrl );
//     console.log('Existing Engines system listener state: ' + EnginesSystemEventsListeners[engines_system_id].readyState );
//     if (EnginesSystemEventsListeners[engines_system_id].readyState === 2) {
//       close_engines_system_event_stream(engines_system_id);
//       EnginesSystemEventsListeners[engines_system_id] = new EventSource(sourceUrl);
//       EnginesSystemEventsListeners[engines_system_id].addEventListener(eventType, func, false);
//       EnginesSystemEventsListeners[engines_system_id].onerror = error_func;
//       console.log('Existing Engines system listener has been restarted. State: ' + EnginesSystemEventsListeners[engines_system_id].readyState );
//     };
//   } else {
//     console.log('Add Engines system listener ' + eventType + ' - ' + sourceUrl );
//     EnginesSystemEventsListeners[engines_system_id] = new EventSource(sourceUrl);
//     EnginesSystemEventsListeners[engines_system_id].addEventListener(eventType, func, false);
//     EnginesSystemEventsListeners[engines_system_id].onerror = error_func;
//   };
//   for (var key in EnginesSystemEventsListeners){
//     console.log('Engines system listener ' + key + ' ' + JSON.stringify(EnginesSystemEventsListeners[key]) );
//   };
// }
//
//
// $(window).on('beforeunload', function(){
//   for (var key in EnginesSystemEventsListeners){
//     close_engines_system_event_stream(key);
//   };
// });
