class EnginesSystemViewUpdateJob < ApplicationJob

  queue_as :default

  def perform(engines_system)
    html = ApplicationController.renderer.render(partial: "/clouds/systems/show", locals: {engines_system: engines_system})
    ActionCable.server.broadcast "engines_system_view_update_channel_#{engines_system.id}", html: html
  end

end
