module EnginesSystems
  class EventsStreamsController < ApplicationController

    include ActionController::Live

    before_action :set_engines_system

    def show
      response.headers['Content-Type'] = 'text/event-stream'
      Rails.logger.info "Opening system events stream for #{@engines_system.url}"
      loop do
        begin
          Rails.logger.warn "Start event stream for #{@engines_system.url}"
          @engines_system.container_event_stream do |event|
            send_event event
          end
        rescue EnginesSystemApiConnectionAuthenticationError,
               EnginesSystemApiConnectionRefusedError,
               EnginesSystemApiConnectionResetError,
               EnginesSystemApiConnectionTimeoutError => e
          Rails.logger.warn "Connection failure on events stream for #{@engines_system.url}: #{e}"
          send_event({type: :disconnected})
          unless e.is_a? (EnginesSystemApiConnectionTimeoutError)
            sleep 5
          end
        end
      end
    rescue ActionController::Live::ClientDisconnected
      Rails.logger.warn "GUI client disconnected from event stream for #{@engines_system.url}"
    rescue => e
      Rails.logger.warn "Unhandled event stream exception for #{@engines_system.url} - e.class: #{e.class}"
    ensure
      Rails.logger.warn "Closing system events stream for #{@engines_system.url}"
      response.stream.close
    end

    def send_event(data_string)
      send_string = "event: engines_system_event\ndata: #{data_string.to_json}\n\n"
      Rails.logger.debug "Relaying event from #{@engines_system.url}: #{send_string}"
      response.stream.write(send_string)
    end

  end
end
