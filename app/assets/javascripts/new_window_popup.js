var bind_engines_popup_windows;

$(document).on('turbolinks:render', function() {
  bind_engines_popup_windows();
});

$(document).ready(function() {
  bind_engines_popup_windows();
});

bind_engines_popup_windows = function() {
  $('body').on('click', 'a[data-popup]', function(event) {
    event.preventDefault();
    window.open($(this).attr('href'), 'engines_popup', 'location=no,height=600,width=800,scrollbars=yes,status=no').focus();
  });
};
