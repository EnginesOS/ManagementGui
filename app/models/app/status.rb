class App
  module Status

    def running?
      state.to_sym == :running
    end

    def state
      @state ||= status[:state]
    end

    # def set_state
    #   @set_state ||= status[:set_state]
    # end

    # def had_oom
    #   @had_oom ||= status[:had_oom]
    # end
    #
    # def restart_required
    #   @restart_required ||= status[:restart_required]
    # end

    def why_stopped?
      @why_stopped ||= status[:why_stop]
    end

    def needs
      @needs ||=
        [ ( 'Ran out of memory' if status[:had_oom] ),
          ( 'Restart' if status[:restart_required] ) ].compact
    end

    # {:state=>"running", :set_state=>"running", :progress_to=>nil, :error=>false, :oom=>false, :had_oom=>false, :restart_required=>false, :why_stop=>nil}


  end
end
