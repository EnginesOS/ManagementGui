$(document).ready ->
  $('body').on 'click', 'a[data-popup]', (event) ->
    event.preventDefault()
    window.open($(this).attr('href'), 'engines_popup', 'location=no,height=600,width=800,scrollbars=yes,status=no').focus()
    return
  return
