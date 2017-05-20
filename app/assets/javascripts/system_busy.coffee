@system_busy_polling = ->

  initial_wait = $('#wait_for_system_progress').data('initial-wait')
  poll_url = $('#wait_for_system_progress').data('poll-url')
  poll_period = $('#wait_for_system_progress').data('poll-period')
  redirect_url = $('#wait_for_system_progress').data('redirect-url')

  setTimeout (->
    check_if_system_busy()
    return
  ), initial_wait

  check_if_system_busy = ->
    setTimeout (->
      $.get poll_url, (data) ->
        if data == 'true'
          check_if_system_busy()
        else
          window.location.replace(redirect_url)
        return
      return
    ), poll_period

  # $(document).off('ajaxError');
  # $(document).ajaxError (event, request, settings) ->
  #   response = request.responseText
  #   if typeof response == 'undefined' or response == ''
  #     check_if_system_busy()
  #   else if request.status == 401
  #     window.location.replace(redirect_url)
  #   else
  #     alert(response)
  #     location.reload()
  #   return

  return
