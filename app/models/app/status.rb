class App
  module Status

    def status
      @status ||= core_app.status
    end

    def running?
      state.to_sym == :running
    end

    def in_set_state?
      status[:state] == status[:set_state]
    end

    def state
      @state ||= status[:state]
    end

    def why_stopped?
      @why_stopped ||= status[:why_stop]
    end

    def needs
      @needs ||=
        [ ( 'Restart' if status[:restart_required] ) ].compact
    end

    def had_oom?
      status[:had_oom]
    end

  end
end
