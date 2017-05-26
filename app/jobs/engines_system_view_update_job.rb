class EnginesSystemViewUpdateJob < ApplicationJob

  queue_as :default

  def perform(engines_system_id)
    ActionCable.server.broadcast "engines_systems_events_channel_#{engines_system_id}", {type: :reload_system}.to_json
  end

end
