# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class EnginesSystemEventsChannel < ApplicationCable::Channel

  attr_reader :thread

  def subscribed
    @engines_system = current_user.user_profile.engines_systems.find(params[:engines_system_id])
    stream_from "engines_systems_events_channel_#{@engines_system.id}_client_#{params[:client_id]}"
    # if connection.server.connections.count == 1
      p "new thread on #{@engines_system.id} (connections count: #{connection.server.connections.count}) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      @thread = Thread.new do
        begin
          # loop do
            @engines_system.container_event_stream do |event|
              ActionCable.server.broadcast "engines_systems_events_channel_#{@engines_system.id}_client_#{params[:client_id]}", event.to_json
            end
            # reject
          # end
        ensure
          ActionCable.server.broadcast "engines_systems_events_channel_#{@engines_system.id}_client_#{params[:client_id]}", {type: :disconnected}.to_json
          # unsubscribed
        end
      end
    # else
    #   byebug
    #   p "old thread on #{@engines_system.id} (connections count: #{connection.server.connections.count}) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    # end
  end

  def unsubscribed
    # if @thread
      p "killing thread for #{@engines_system} !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1"
      @thread.kill
    # end
  end

end
