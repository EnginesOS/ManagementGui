class EnginesSystemViewUpdateJob < ApplicationJob

  queue_as :default

  def perform(engines_system, message=nil)
    # sleep 1 # Hack to work around sqlite concurrency problem. System view can trigger db write (if needs to add or remove apps or services). When this job is triggered by action that also writes to db, sqlite throws error.
    ActionCable.server.broadcast "engines_system_view_update_channel_#{engines_system.id}", html: html(engines_system, message)
  rescue => e
    if ( (!Rails.env.development?) && e.is_a?(Redis::TimeoutError) )
      # doesn't work when redis is down/restarting/paused
      raise EnginesError.new "The redis service is not responding. Please ensure that the redis service is running."
    else
      raise e
    end
  end

  def html(engines_system, message)
    ApplicationController.renderer.render(partial: "/clouds/systems/show", locals: {engines_system: engines_system, message: message})
  end

end
