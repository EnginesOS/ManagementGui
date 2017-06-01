class EnginesSystemViewUpdateJob < ApplicationJob

  queue_as :default

  def perform(engines_system)
    ActionCable.server.broadcast "engines_system_view_update_channel_#{engines_system.id}", html: html(engines_system)
  end

  def html(engines_system)
    ApplicationController.renderer.render(partial: "/clouds/systems/show", locals: {engines_system: engines_system})
  # rescue EnginesError::ApiConnectionAuthenticationError => e
  #   ApplicationController.renderer.render(partial: "/clouds/systems/show_with_authentication_error", locals: {engines_system: engines_system, e: e})
  # rescue EnginesError => e
  #   ApplicationController.renderer.render(partial: "/clouds/systems/show_with_error", locals: {engines_system: engines_system, e: e})
  end

end
