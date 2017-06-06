class Service
  module Status

    def running?
      state.to_sym == :running
    end

    def state
      @state ||= status[:state]
    end

    def why_stopped?
      @why_stopped ||= status[:why_stop]
    end

    def needs
      @needs ||=
        [ ( 'Ran out of memory' if status[:had_oom] ) ].compact
    end

  end
end
