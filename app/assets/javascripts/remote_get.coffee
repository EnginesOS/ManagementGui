remote_gets = ->
  $('[data-behavior~=remote_get]').each ->
    remote_get $(this).attr('data-url')
    return
  return

window.remote_get = (url) ->
  $.ajax
    url: url
    dataType: 'script'
  return

$(document).ready ->
  remote_gets()
  return
$(document).on 'turbolinks:render', ->
  remote_gets()
  return
