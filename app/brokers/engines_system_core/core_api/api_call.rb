module EnginesSystemCore
  module CoreApi
    module ApiCall

      private

      def api_call(http_method, api_route, params, opts={})
        timeout = ( opts[:timeout] || 10 )
        if http_method == :post
          Rails.logger.debug "#{http_method} api_route: #{@api_url}/v0/#{api_route}, post_body_api_vars: #{params}, access_token: #{@token}"
          post_body = {api_vars: params}.to_json
          RestClient::Request.execute(method: :post, url: "#{@api_url}/v0/#{api_route}", payload: post_body, timeout: timeout, open_timeout: timeout, headers: { access_token: @token } ) # , content_type: :json )
        else
          Rails.logger.debug "#{http_method} api_route: #{@api_url}/v0/#{api_route}, query_string_params: #{params}, access_token: #{@token}"
          RestClient::Request.execute(method: http_method, url: "#{@api_url}/v0/#{api_route}", timeout: timeout, open_timeout: timeout, headers: { params: params, access_token: @token } ) #, verify_ssl: false, content_type: :json )
        end.tap { |result| Rails.logger.debug "#{http_method} api_route: #{@api_url}/v0/#{api_route}\nresult:\n#{result}" }
      rescue RestClient::NotFound => e
        raise EnginesError.new "Failed to load the requested resource on Engines system #{@name} at #{@api_url}.\n\n#{system_error_message_from(e)}"
      rescue URI::InvalidURIError # normally thrown when user enters an invalid url for an engines system.
        raise EnginesError.new "Invalid URL for Engines system #{@name} at #{@api_url}."
      rescue OpenSSL::SSL::SSLError => e # normally throw when SSL certificate is invalid.
        raise EnginesError.new "The security certificate is invalid for Engines system #{@name} at #{@api_url}."
      rescue RestClient::SSLCertificateNotVerified
        raise EnginesError.new "The security certificate is not trusted for Engines system #{@name} at #{@api_url}."
      rescue Errno::EHOSTUNREACH, Errno::ENETUNREACH # normally thrown when there is a routing or network problem.
        raise EnginesError::ApiConnectionError.new "Cannot establish connection to Engines system #{@name} at #{@api_url}."
      rescue Errno::ECONNREFUSED => e # normally thrown when system is offline.
        raise EnginesError::ApiConnectionError.new "Connection refused to Engines system #{@name} at #{@api_url}."
      rescue Errno::ECONNRESET => e # normally thrown after system update.
        raise EnginesError::ApiConnectionError.new "Connection has been reset to Engines system #{@name} at #{@api_url}."
      rescue RestClient::ServerBrokeConnection => e  # normally thrown when the system has been online and then goes offline (when system stopped, for example).
        raise EnginesError::ApiConnectionError.new "Connection has been broken to Engines system #{@name} at #{@api_url} ."
      rescue RestClient::Exceptions::OpenTimeout, RestClient::Exceptions::ReadTimeout => e
        raise EnginesError::ApiConnectionError.new "The connection has timed-out to Engines system #{@name} at #{@api_url}."
      rescue RestClient::Forbidden => e # can't authenticate. Throwing custom error so that gui knows to present authentication link
        raise EnginesError::ApiConnectionAuthenticationError.new "Failed to authenticate the connection with the Engines system."
      rescue => e
        Rails.logger.warn \
        "++++++++\n"\
        "UNHANDLED ENGINES API ERROR in EnginesSystemCore::CoreApi::ApiCall.api_call\n"\
        "api call: #{http_method} #{api_route} #{params}\n"\
        ">>>>> e.class: #{e.class}\n"\
        ">>>>> e.response: #{e.try(:response) || 'n/a'}\n"\
        ">>>>> e.inspect: #{e.inspect}\n"\
        "++++++++"
        raise
      ensure
        Rails.logger.debug "#{http_method} api_route: #{@api_url}/v0/#{api_route} - done"
      end

      def get(api_route, opts)
        params = opts[:params] || {}
        api_call_opts = { timeout: opts[:timeout] }
        parse api_call( :get, api_route, params, api_call_opts ), opts[:expect]
      end

      def post(api_route, opts)
        params = opts[:params] || {}
        api_call_opts = { timeout: opts[:timeout] }
        parse api_call( :post, api_route, params, api_call_opts ), opts[:expect]
      end

      def delete(api_route, opts)
        params = opts[:params] || {}
        api_call_opts = { timeout: opts[:timeout] }
        parse api_call( :delete, api_route, params, api_call_opts ), opts[:expect]
      end

      def parse(api_call_result, expected_content)
        # byebug if Rails.env.development? && !( api_call_result.net_http_res.content_type != "application/json" || api_call_result.net_http_res.content_type != "text/plain" )
        result = api_call_result.body.to_s
        Rails.logger.info "Engines System API result: #{result}  result_class: #{result.class}"
        if api_call_result.net_http_res.content_type == "application/json" && expected_content == :json
          begin
            JSON.parse result, symbolize_names: true
          rescue
            raise EnginesError::ApiParseError.new "Failed to parse JSON.", result
          end
        elsif api_call_result.net_http_res.content_type == "text/plain" && expected_content == :plain_text
          # if result[0] == '"' && result[-1] == '"'
          #   byebug if Rails.env.development?
          #   result[1..-2] # remove leading and trailing quotation marks
          # else
            result
          # end
        elsif api_call_result.net_http_res.content_type == "text/plain" && expected_content == :boolean
          result == 'true'
        elsif ( api_call_result.net_http_res.content_type == "text/plain" || api_call_result.net_http_res.content_type == "application/octet-stream" ) && expected_content == :file
          result
        else
          raise EnginesError::ApiParseError.new "Invalid content type. Expected #{expected_content} #{expected_content.class} but received #{api_call_result.net_http_res.content_type} #{api_call_result.net_http_res.content_type.class}.", result
        end
      rescue => e
        Rails.logger.warn "Engines System API result parse #{expected_content} failed: #{e}"
        raise e
      end

      private

      def system_error_message_from(e)
        JSON.parse(e.response, symbolize_names: true)[:error_object][:error_mesg] || raise
      rescue
        "Failed to extract system error message from API response."
      end

    end
  end
end
