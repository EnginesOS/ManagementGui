function local_system_busy_polling(engines_system_id, poll_url, redirect_url, initial_wait=10000, poll_period=5000) {

  // var initial_wait = $('#wait_for_system_progress').data('initial-wait');
  // var poll_url = $('#wait_for_system_progress').data('poll-url');
  // var poll_period = $('#wait_for_system_progress').data('poll-period');
  // var redirect_url = $('#wait_for_system_progress').data('redirect-url');

  setTimeout((function() {
    check_if_system_busy();
  }), initial_wait);

  var check_if_system_busy = function() {
    return setTimeout((function() {
      $.get(poll_url, function(data) {
        if (data === 'true') {
          check_if_system_busy();
        } else {
          // alert(redirect_url);
          window.location.replace(redirect_url);
        }
      }).fail(function(event, request, settings) {
        var response;
        response = request.responseText;
        if (typeof response === 'undefined' || response === '') {
          check_if_system_busy();
        } else if (request.status === 401) {
          window.location.replace(redirect_url);
        } else {
          alert(response);
          location.reload();
        };
      });
    }), poll_period);
  };
};

// var show_waiting_for_system_reload_timer = function(selector, wait){
//   $(selector).html(wait/1000);
//   var countdown_waiting_for_system_reload_timer = function(){
//     setTimeout((function() {
//       seconds = parseInt( $(selector).html() ) - 1;
//       $(selector).html(seconds);
//       if ( seconds > 0 ) {
//         countdown_waiting_for_system_reload_timer();
//       };
//     }), 1000);
//   };
//   countdown_waiting_for_system_reload_timer();
// };

function system_busy_polling(engines_system_id, poll_url, callback_url, initial_wait=10000, poll_period=5000) {

  // show_waiting_for_system_reload_timer('#waiting_for_engines_system_reload_timer_' + engines_system_id, initial_wait);
  setTimeout((function() {
    check_if_system_busy();
  }), initial_wait);

  var check_if_system_busy = function() {
    // show_waiting_for_system_reload_timer('#waiting_for_engines_system_reload_timer_' + engines_system_id, poll_period);
    return setTimeout((function() {
      $.get(poll_url, function(data) {
        if (data === 'true') {
          check_if_system_busy();
        } else {
          remote_get(callback_url);
        }
      }).fail(function(event, request, settings) {
          check_if_system_busy();
      });
    }), poll_period);
  };
};
