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
        detail: { params: params_detail,
                  system_response: system_response }
      }
    }
  end

  private

  def params_detail
    if Rails.env.development?
      @context.params.inspect
    else
      @context.params.to_h
    end
  end

  def error_message
    @error.to_s.encode('UTF-8').sub(Rails.root.to_s, '')
  rescue => e
    "Failed to extract error message from error object. #{e}"
  end

  def application_backtrace
    @error.backtrace.map{ |line| line.sub(Rails.root.to_s, '').split(':in ')[0] }.select{ |line| line.split('/')[1] == "app" }
  end

  def system_response
    JSON.parse(@error.response.encode('UTF-8'))
  rescue
    'n/a'
  end

end
