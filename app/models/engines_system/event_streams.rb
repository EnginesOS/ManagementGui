class EnginesSystem
  module EventStreams

    def container_event_stream(&block)
      core_system.container_event_stream do |event|
        # if event == '' || event == "\n"
        #   # yield({type: :empty})
        #   yield({type: :heartbeat})
        # elsif event == "{\"no_op\":true}"
        #   yield({type: :heartbeat})
        # else
          begin
            parsed_event = JSON.parse(event).symbolize_keys
            if parsed_event[:container_name].blank?
              yield({type: :heartbeat})
            else
              yield({ type: :update_container_state,
                      name: parsed_event[:container_name],
                      state: parsed_event[:state] })
            end
          rescue JSON::ParserError
            yield({type: :heartbeat})
          end
        # end
      end
    end

    def builder_log_stream(&block)
      core_system.builder_log_stream(&block)
    end

  end
end
