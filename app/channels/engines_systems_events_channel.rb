# # Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
# class EnginesSystemsEventsChannel < ApplicationCable::Channel
#
#   # def subscribed
#   #   p "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Subscribed to engines_systems_events_channel"
#   #   current_user.user_profile.engines_systems.each do |engines_system|
#   #     engines_system.update(terminate_streams: false)
#   #     route_engines_system_events engines_system
#   #   end
#   #   stream_from "engines_systems_events_channel_#{current_user.id}"
#   # end
#   #
#   # def unsubscribed
#   #   p "Unsubscribed from engines_systems_events_channel"
#   #   current_user.user_profile.engines_systems.each do |engines_system|
#   #     engines_system.update(terminate_streams: true)
#   #   end
#   # end
#   #
#   # def speak(data)
#   #   # @engines_system = current_user.user_profile.
#   #   #                     engines_systems.find(engines_system_id)
#   #   # return unless @engines_system
#   #   p "--------- to engines_systems_events_channel_#{current_user.id}"
#   #   ActionCable.server.broadcast "engines_systems_events_channel_#{current_user.id}", data # , user: current_user
#   # end
#   #
#   # private
#   #
#   # def route_engines_system_events(engines_system)
#   #   # EnginesSystems::EventStreamsBroker.perform(self, engines_system)
#   #   EnginesSystemEventsBrokerJob.perform_later(current_user, engines_system)
#   # end
#
# end
