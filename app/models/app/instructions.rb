class App
  module Instructions

    def perform_instruction(action)
      result = core_app.send action
      if result
        {type: :success, message: "Sent #{action} instruction."}
      else
        { type: :error, message: "Failed to send #{action} instruction." }
      end
    end

  end
end
