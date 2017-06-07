class EnginesSystemEventsChannel < ApplicationCable::Channel

  attr_reader :thread

  def subscribed
    @engines_system = current_user.user_profile.engines_systems.find(params[:engines_system_id])
    stream_from "engines_systems_events_channel_#{@engines_system.id}_client_#{params[:client_id]}"
    @thread = Thread.new do
      begin
        @engines_system.container_event_stream do |event|
          ActionCable.server.broadcast "engines_systems_events_channel_#{@engines_system.id}_client_#{params[:client_id]}", event.to_json
        end
      ensure
        ActionCable.server.broadcast "engines_systems_events_channel_#{@engines_system.id}_client_#{params[:client_id]}", {type: :disconnected}.to_json
      end
    end
  end

  def unsubscribed
    @thread.kill
  end

end
