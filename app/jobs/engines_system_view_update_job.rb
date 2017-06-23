class EnginesSystemViewUpdateJob < ApplicationJob

  queue_as :default

  def perform(engines_system, message=nil)
    ActionCable.server.broadcast "engines_system_view_update_channel_#{engines_system.id}", html: html(engines_system, message)
  rescue Redis::TimeoutError
    # doesn't work when redis is down/restarting/paused
  end

  def html(engines_system, message)
    ApplicationController.renderer.render(partial: "/clouds/systems/show", locals: {engines_system: engines_system, message: message})
  end

end
