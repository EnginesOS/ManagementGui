var remote_gets;

remote_gets = function() {
  $('[data-behavior~=remote_get]').each(function() {
    remote_get($(this).attr('data-url'));
  });
};

window.remote_get = function(url) {
  show_waiting_spinner();
  $.ajax({
    url: url,
    dataType: 'script'
  });
};

$(document).ready(function() {
  remote_gets();
});

$(document).on('turbolinks:render', function() {
  remote_gets();
});
