module EnginesSystemCore
  module CoreApi
    module ApiStream

      # def uri_object
      #   @uri_object ||=
      # end
      #
      # def scheme
      #   uri_object.scheme
      # end
      #
      # def host
      #   uri_object.host
      # end
      #
      # def port
      #   uri_object.port
      # end

      def read_stream(api_path)
        Rails.logger.debug "API events from #{@system_url} - build get"
        uri = URI @system_url
        net_http = Net::HTTP.new(uri.host,uri.port)
        net_http.use_ssl = (uri.scheme == 'https')
        net_http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        net_http.start do |http|
          begin
            Rails.logger.debug "API events from #{@system_url} - build get"
            request = Net::HTTP::Get.new URI("#{@system_url}/v0/#{api_path}")
            request['access_token'] = @token
            Rails.logger.debug "API events from #{@system_url} - make request"
            # byebug
            http.request(request) do |response|
              Rails.logger.debug "API events from #{@system_url} request response: #{response}"
              response.read_body do |event|
                Rails.logger.debug "API events from #{@system_url} response body event: #{event}"
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
