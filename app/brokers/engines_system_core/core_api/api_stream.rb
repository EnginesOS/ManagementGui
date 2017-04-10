module EnginesSystemCore
  module CoreApi
    module ApiStream

      def read_stream(url, token)
        uri = URI(url)
        Net::HTTP.start(uri.host, uri.port) do |http|
          begin
            request = Net::HTTP::Get.new(uri)
            request['access_token'] = token
            http.request(request) do |response|
              Rails.logger.debug "API events from #{url} request response: #{response}"
              # raise EnginesSystemApiConnectionAuthenticationError if response.is_a?(Net::HTTPForbidden)
              response.read_body do |event|
                Rails.logger.debug "API events from #{url} response body event: #{event}"
                yield event
              end
            end
          rescue EOFError
            return
          rescue Encoding::UndefinedConversionError
            p "Encoding error. Continue..."
          rescue => e
            raise EnginesError.new "Failed to read to build log. #{e}"
          # rescue Encoding::UndefinedConversionError
          #   raise EnginesError.new 'Failed to read to build log. Event stream encoding error.'
          # rescue Errno::ECONNREFUSED
          #   raise EnginesSystemApiConnectionRefusedError
          # rescue Errno::ECONNRESET
          #   raise EnginesSystemApiConnectionResetError
          # rescue Net::OpenTimeout
          #   raise EnginesSystemApiConnectionTimeoutError
          end
        end
      end

    end
  end
end
