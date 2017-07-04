module EnginesSystemCore
  class CoreSystem
    module EventStreams

      def container_event_stream
        read_stream(
        "containers/events/stream") do |chunk|
          chunk.split("\n").each do |line|
            Rails.logger.debug "Stream event from #{@api_url}: #{line.class} #{line}"
            yield line
          end
        end
      end

      def builder_log_stream
        read_stream(
        "engine_builder/follow_stream") do |chunk|
          begin
            chunk.split("\n").each do |line|
              yield line
            end
          rescue => e
            yield "\n\n\n\u001b[91m+++++++++++++Build log error... #{e}\n\n\n"
          end
        end
      end

    end
  end
end
