module EnginesSystemCore
  class CoreSystem
    module EventStreams

      def container_event_stream
        read_stream(
        "#{@api_url}/v0/containers/events/stream", @token) do |chunk|
          chunk.split("\n").each do |line|
            Rails.logger.debug "Stream event from #{@api_url}: #{line.class} #{line}"
            yield line
          end
        end
      end

      def builder_log_stream
        read_stream(
        "#{@api_url}/v0/engine_builder/follow_stream", @token) do |chunk|
          begin
            p "Build log chunk: #{chunk}"
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
