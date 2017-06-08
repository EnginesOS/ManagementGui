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
              # Rails.logger.debug "API events from #{url} request response: #{response}"
              response.read_body do |event|
                # Rails.logger.debug "API events from #{url} response body event: #{event}"
                yield event
              end
            end
          rescue EOFError
            return
          end
        end
      end

    end
  end
end
