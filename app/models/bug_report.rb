class BugReport

  def initialize(context, error)
    @context = context
    @error = error
  end

  def data
    {
      schema: {
        type: :exception_report,
        version: {major: 0, minor: 1},
        origin: 'Engines System Manager 0.3'
      },
      exception: {
        class: @error.class,
        message: error_message,
        backtrace: application_backtrace,
        detail: { params: @context.params.inspect,
                  system_response: system_response }
      }
    }
  end

  private

  def error_message
    @error.to_s.sub(Rails.root.to_s, '')
  end

  def application_backtrace
    @error.backtrace.map{ |line| line.sub(Rails.root.to_s, '').split(':in ')[0] }.select{ |line| line.split('/')[1] == "app" }
  end

  def system_response
    JSON.parse(@error.response)
  rescue
    'n/a'
  end

end
