window.remote_get = function(url, show_spinner) {
  if (show_spinner) {
    show_waiting_spinner();
  };
  $.ajax({
    url: url,
    dataType: 'script'
  });
};
