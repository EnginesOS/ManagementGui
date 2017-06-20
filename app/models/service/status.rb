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
      # Service don't have any needs...yet...maybe in future.
      @needs ||=
        [ ].compact
    end

    def had_oom?
      status[:had_oom]
    end

  end
end
