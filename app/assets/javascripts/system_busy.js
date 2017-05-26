function system_busy_polling() {

  var initial_wait = $('#wait_for_system_progress').data('initial-wait');
  var poll_url = $('#wait_for_system_progress').data('poll-url');
  var poll_period = $('#wait_for_system_progress').data('poll-period');
  var redirect_url = $('#wait_for_system_progress').data('redirect-url');

  setTimeout((function() {
    check_if_system_busy();
  }), initial_wait);

  var check_if_system_busy = function() {
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
          alert(response);
          location.reload();
        };
      });
    }), poll_period);
  };
};
