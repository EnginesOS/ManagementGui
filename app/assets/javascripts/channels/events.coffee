# $(document).on 'turbolinks:load', ->
#   if document.getElementById("subscribe_to_engines_systems_events_channel") # if a specific field is found
#     App.events = App.cable.subscriptions.create 'EnginesSystemsEventsChannel',
#       connected: ->
#         # $(document).ready ->
#         #   return
#
#       disconnected: ->
#
#       received: (data) ->
#         # alert(data['event'])
#         eval(data['event'])
#         return
#
#   # speak: (data) ->
#   #   @perform 'speak', event: data
#
#   else if App.task # if I'm not on the page where I want to be connected, unsubscribe and set it to null
#     App.task.unsubscribe()
#     App.task = null
#
# $(document).ready ->
#   alert('page ready');
#
# $(document).on 'turbolinks:load', ->
#   alert('turbolinks load');
