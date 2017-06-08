var fadeInSpinner = function() {
  $('#waiting_spinner .waiting_spinner_container').hide();
  $('#waiting_spinner').show();
  setTimeout((function() {
    $('#waiting_spinner .waiting_spinner_container').fadeIn(1000);
  }), 500);
};

var bind_show_waiting_spinner_click_event = function() {
  $('.show_waiting_spinner').unbind('click');
  $('.show_waiting_spinner').click(function() {
    show_waiting_spinner();
  });
};

window.show_waiting_spinner = function() {
  fadeInSpinner();
};

window.hide_waiting_spinner = function() {
  $('#waiting_spinner').fadeOut();
};

$(document).ajaxComplete(function() {
  bind_show_waiting_spinner_click_event();
  hide_waiting_spinner();
});

$(document).on('turbolinks:load', function() {
  bind_show_waiting_spinner_click_event();
  hide_waiting_spinner();
});

$(window).unload(function() {
  hide_waiting_spinner();
});
