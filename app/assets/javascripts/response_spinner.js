var bind_show_wait_for_system_response_spinner_click_event, fadeInSpinner;

fadeInSpinner = function() {
  $('#wait_for_system_response_spinner .system_response_spinner_container').hide();
  $('#wait_for_system_response_spinner').show();
  setTimeout((function() {
    $('#wait_for_system_response_spinner .system_response_spinner_container').fadeIn(1000);
  }), 1000);
};

bind_show_wait_for_system_response_spinner_click_event = function() {
  $('.show_wait_for_system_response_spinner').unbind('click');
  return $('.show_wait_for_system_response_spinner').click(function() {
    return show_wait_for_system_response_spinner();
  });
};

window.show_wait_for_system_response_spinner = function() {
  return fadeInSpinner();
};

window.hide_wait_for_system_response_spinner = function() {
  return $('#wait_for_system_response_spinner').fadeOut();
};

$(document).ajaxStart(function() {
  show_wait_for_system_response_spinner();
});

$(document).ajaxComplete(function() {
  bind_show_wait_for_system_response_spinner_click_event();
  hide_wait_for_system_response_spinner();
});

$(document).on('turbolinks:load', function() {
  bind_show_wait_for_system_response_spinner_click_event();
  hide_wait_for_system_response_spinner();
});

$(window).unload(function() {});
