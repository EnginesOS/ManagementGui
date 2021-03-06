class Service
  module Status

    def status
      @status ||= core_service.status
    end

    def in_set_state?
      status[:state] == status[:set_state]
    end

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
