module EnginesSystemCore
  class CoreSystem
    module EventStreams

      def container_event_stream
        read_stream(
        "#{@api_url}/v0/containers/events/stream", @token) do |event|
          Rails.logger.debug "Stream event from #{@api_url}: #{event.class} <#{event}>"
          yield event
        end
      end

      def builder_log_stream
        read_stream(
        "#{@api_url}/v0/engine_builder/follow_stream", @token) do |chunk|
          chunk.split("\n").each do |line|
            Rails.logger.debug "Log line: #{line} - #{line.class} #{line.length}"
            yield line
          end
        end
      end

    end
  end
end
