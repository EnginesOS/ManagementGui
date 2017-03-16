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
        origin: 'Engines Manager v0.3'
      },
      exception: {
        class: @error.class,
        message: @error.to_s,
        backtrace: application_backtrace,
        detail: { params: @context.params.inspect }
      }
    }
  end

  private

  def application_backtrace
    @error.backtrace.map{ |line| line.sub(Rails.root.to_s, '').split(':in ')[0] }.select{ |line| line.split('/')[1] == "app" }
  end

end
