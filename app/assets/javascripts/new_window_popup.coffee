$(document).on 'turbolinks:render', ->
  bind_engines_popup_windows()
  return

$(document).ready ->
  bind_engines_popup_windows()
  return

bind_engines_popup_windows = ->
  $('body').on 'click', 'a[data-popup]', (event) ->
    event.preventDefault()
    window.open($(this).attr('href'), 'engines_popup', 'location=no,height=600,width=800,scrollbars=yes,status=no').focus()
    return
  return
