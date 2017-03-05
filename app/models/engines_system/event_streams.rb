class EnginesSystem
  module EventStreams

    def container_event_stream(&block)
      core_system.container_event_stream do |event|
        if event == '' || event == "\n"
          yield({type: :empty})
        elsif event == "{\"no_op\":true}"
          yield({type: :heartbeat})
        else
          parsed_event = JSON.parse(event).symbolize_keys
          yield({ type: :update_container_state,
                  name: parsed_event[:container_name],
                  state: parsed_event[:state] })
        end
      end
    end

    def builder_log_stream(&block)
      core_system.builder_log_stream(&block)
    end

  end
end
