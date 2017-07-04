class EnginesSystemEventsChannel < ApplicationCable::Channel

  attr_reader :thread

  def subscribed
    @engines_system = current_user.user_profile.engines_systems.find(params[:engines_system_id])
    connection_id = (Time.now.to_f * 1e100).to_i
    # user and connection ids give each client window its own system events channel
    stream_from "engines_systems_events_channel_#{@engines_system.id}_user_#{current_user.id}_connection_#{connection_id}"
    @thread = Thread.new do
      begin
        @engines_system.container_event_stream do |event|
          ActionCable.server.broadcast "engines_systems_events_channel_#{@engines_system.id}_user_#{current_user.id}_connection_#{connection_id}", event.to_json
        end
      ensure
        ActionCable.server.broadcast "engines_systems_events_channel_#{@engines_system.id}_user_#{current_user.id}_connection_#{connection_id}", {type: :disconnected}.to_json
      end
    end
  end

  def unsubscribed
    @thread.kill
  end

end
