# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class BuildLogChannel < ApplicationCable::Channel

  def subscribed
    @engines_system = current_user.user_profile.engines_systems.find(params[:engines_system_id])
    # user client identifier to give each client window its own build log channel
    p "!!!!!!!!!!!!!!!!!!!!!!!! params[:client_id] = #{params[:client_id]}"
    # byebug
    stream_from "build_log_channel_#{@engines_system.id}_client_#{params[:client_id]}"
    @thread = Thread.new do
      @engines_system.builder_log_stream do |log_line|
        ActionCable.server.broadcast "build_log_channel_#{@engines_system.id}_client_#{params[:client_id]}", {type: :log_line, line: log_line}.to_json
      end
      ActionCable.server.broadcast "build_log_channel_#{@engines_system.id}_client_#{params[:client_id]}", {type: :log_eof}.to_json
      # EnginesSystemViewUpdateJob.perform_later(@engines_system)
      p "#{connection.server.connections.count}$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    end
  end

  def unsubscribed
    @thread.kill
  end

end
