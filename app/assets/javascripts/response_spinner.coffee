fadeInSpinner = ->
  $('#wait_for_system_response_spinner .system_response_spinner_container').hide()
  $('#wait_for_system_response_spinner').show()
  setTimeout (->
    $('#wait_for_system_response_spinner .system_response_spinner_container').fadeIn 1000
    return
  ), 1000
  return

bind_show_wait_for_system_response_spinner_click_event = ->
  $('.show_wait_for_system_response_spinner').unbind 'click' #don't want multiple events or will get multiple spinners appearing on click
  $('.show_wait_for_system_response_spinner').click ->
    show_wait_for_system_response_spinner()

#give show_wait_for_system_response_spinner global/window scope so other js modules can enable/disable spinner
window.show_wait_for_system_response_spinner = -> fadeInSpinner() #fadeIn 2000
window.hide_wait_for_system_response_spinner = -> $('#wait_for_system_response_spinner').fadeOut()

$(document).ajaxStart ->
  show_wait_for_system_response_spinner()
  return
$(document).ajaxComplete ->
  bind_show_wait_for_system_response_spinner_click_event()
  hide_wait_for_system_response_spinner()
  return

$(document).on 'turbolinks:load', ->
  bind_show_wait_for_system_response_spinner_click_event()
  hide_wait_for_system_response_spinner()
  return
$(window).unload ->
  # hide_wait_for_system_response_spinner()
  return
# $(window).location.on 'change', ->
