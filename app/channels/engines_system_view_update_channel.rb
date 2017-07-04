class EnginesSystemViewUpdateChannel < ApplicationCable::Channel

  attr_reader :thread

  def subscribed
    @engines_system = current_user.user_profile.engines_systems.find(params[:engines_system_id])
    stream_from "engines_system_view_update_channel_#{@engines_system.id}"
  end

  def unsubscribed
  end

end
