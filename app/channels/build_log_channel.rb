class BuildLogChannel < ApplicationCable::Channel

  def subscribed
    @engines_system = current_user.user_profile.engines_systems.find(params[:engines_system_id])
    connection_id = (Time.now.to_f * 1e100).to_i
    # user and connection ids give each client window its own build log channel
    stream_from "build_log_channel_#{@engines_system.id}_user_#{current_user.id}_connection_#{connection_id}"
    @thread = Thread.new do
      @engines_system.builder_log_stream do |log_line|
        ActionCable.server.broadcast "build_log_channel_#{@engines_system.id}_user_#{current_user.id}_connection_#{connection_id}", {type: :log_line, line: log_line}.to_json
      end
      ActionCable.server.broadcast "build_log_channel_#{@engines_system.id}_user_#{current_user.id}_connection_#{connection_id}", {type: :log_eof}.to_json
    end
  end

  def unsubscribed
    @thread.kill
  end

end
