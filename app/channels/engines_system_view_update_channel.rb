# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class EnginesSystemViewUpdateChannel < ApplicationCable::Channel

  attr_reader :thread

  def subscribed
    @engines_system = current_user.user_profile.engines_systems.find(params[:engines_system_id])
    stream_from "engines_system_view_update_channel_#{@engines_system.id}"
    # ActionCable.server.broadcast "engines_system_view_update_channel_#{params[:engines_system_id]}", html: 'hi'
  end

  def unsubscribed
  end

end
