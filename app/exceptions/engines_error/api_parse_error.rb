class EnginesError
  class ApiParseError < StandardError

    def initialize(message, response)
      @message = message
      @response = response
    end

    def to_s
      @message
    end

    def response
      @response
    end

  end
end
