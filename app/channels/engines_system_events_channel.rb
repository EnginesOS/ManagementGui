# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class EnginesSystemEventsChannel < ApplicationCable::Channel

  def subscribed
    @engines_system = current_user.user_profile.engines_systems.find(params[:engines_system_id])
    stream_from "engines_systems_events_channel_#{@engines_system.id}"
    if connection.server.connections.count == 1
      @thread = Thread.new do
        begin
          loop do
            @engines_system.container_event_stream do |event|
              ActionCable.server.broadcast "engines_systems_events_channel_#{@engines_system.id}", event.to_json
            end
          end
        rescue => e
          unsubscribed
        end
      end
    end
  end

  def unsubscribed
    if @thread
      ActionCable.server.broadcast "engines_systems_events_channel_#{@engines_system.id}", {type: :disconnected}.to_json
      p "killing thread for #{@engines_system}"
      @thread.kill
    end
  end

end
