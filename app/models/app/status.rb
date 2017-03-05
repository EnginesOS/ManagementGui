class App
  module Status

    def running?
      state.to_sym == :running
    end


  end
end
