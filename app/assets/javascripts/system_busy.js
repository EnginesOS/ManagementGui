function local_system_busy_polling(engines_system_id, poll_url, redirect_url, initial_wait, poll_period) {

  var attempt_count = 0;
  initial_wait = initial_wait || 10000;
  poll_period = poll_period || 5000;

  setTimeout((function() {
    check_if_system_busy();
  }), initial_wait);

  var check_if_system_busy = function() {
    if ( attempt_count < 50 ) {
      attempt_count = attempt_count + 1;
      return setTimeout((function() {
        $.get(poll_url, function(data) {
          if (data === 'true') {
            check_if_system_busy();
          } else {
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
            alert_modal('Polling error', response);
          };
        });
      }), poll_period);
    } else {
      alert_modal('Polling error', 'Failed to connect with application server.');
    };
  };
};

function system_busy_polling(engines_system_id, poll_url, callback_url, initial_wait, poll_period) {

  var attempt_count = 0;
  initial_wait = initial_wait || 10000;
  poll_period = poll_period || 5000;

  // show_waiting_for_system_reload_timer('#waiting_for_engines_system_reload_timer_' + engines_system_id, initial_wait);
  setTimeout((function() {
    check_if_system_busy();
  }), initial_wait);

  var check_if_system_busy = function() {
    if ( attempt_count < 50 ) {
      attempt_count = attempt_count + 1;
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
    } else {
      show_system_failed_to_reconnect_flash_message();
      remove_engines_system_connecting_message();
    };
  };

  var show_system_failed_to_reconnect_flash_message = function() {
    $('#engines_system_' + engines_system_id + ' .flash_messages').html(
      '<div class="alert alert-danger alert-dismissible"> \
        <button name="button" type="button" class="close" data-dismiss="alert"> \
          × \
        </button> \
        Failed to connect. \
      </div>'
    );
  };

  var remove_engines_system_connecting_message = function() {
    $('#engines_system_' + engines_system_id + ' .engines_system_connecting_message').remove();
  };

};
