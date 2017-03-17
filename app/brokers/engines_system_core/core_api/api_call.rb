module EnginesSystemCore
  module CoreApi
    module ApiCall

      private

      def api_call(http_method, api_route, params, file=nil)
        if http_method == :post

          post_body = file.present? ? { file: file } : {api_vars: params}.to_json
          Rails.logger.debug "#{http_method} api_route: #{@api_url}/v0/#{api_route}, post_body_api_vars: #{params}, access_token: #{@token}"
          RestClient.post( "#{@api_url}/v0/#{api_route}", post_body, access_token: @token ) # , content_type: :json )
        else

          Rails.logger.debug "#{http_method} api_route: #{@api_url}/v0/#{api_route}, query_string_params: #{params}, access_token: #{@token}"
          RestClient.send( http_method, "#{@api_url}/v0/#{api_route}", params: params, access_token: @token, verify_ssl: true ) #, verify_ssl: false, content_type: :json )
        end
      rescue SocketError => e # normally thrown when invalid url is provided for server address
        Rails.logger.debug "EnginesSystemApiConnectionTcpError: #{e.inspect}"
        raise EnginesSystemApiConnectionTcpError
      rescue OpenSSL::SSL::SSLError => e # normally throw when user enters
        Rails.logger.debug "EnginesSystemApiConnectionSslError: #{e.inspect}"
        raise EnginesSystemApiConnectionSslInvalid
      rescue RestClient::SSLCertificateNotVerified
        Rails.logger.debug "EnginesSystemApiConnectionSslError: #{e.inspect}"
        raise EnginesSystemApiConnectionSslNotTrusted
      rescue Errno::ECONNREFUSED => e # normally thrown when system is offline.
        Rails.logger.debug "EnginesSystemApiConnectionRefusedError: #{e.inspect}"
        raise EnginesSystemApiConnectionRefusedError
      rescue Errno::ECONNRESET => e # normally thrown after system update.
        Rails.logger.debug "EnginesSystemApiConnectionResetError: #{e.inspect}"
        raise EnginesSystemApiConnectionResetError
      rescue RestClient::ServerBrokeConnection => e  # normally thrown when the system has been online and then goes offline (when system stopped, for example).
        Rails.logger.debug "EnginesSystemApiConnectionResetError: #{e.inspect} #{e.response}"
        raise EnginesSystemApiConnectionResetError
        # elsif error.is_a?(RestClient::BadRequest)
        #   raise EnginesSystemApiConnectionRefusedError
      # rescue RestClient::BadRequest => e
      #   Rails.logger.debug "EnginesSystemApiConnectionBadRequestError: #{e.inspect} #{e.response}"
      #   raise EnginesSystemApiConnectionBadRequestError.new(e)
      rescue URI::InvalidURIError # normally thrown when user enters an invalid url for an engines system
        Rails.logger.debug "EnginesSystemApiConnectionInvalidUrlError: #{e.inspect}"
        raise EnginesSystemApiConnectionInvalidUrlError
      rescue RestClient::NotFound => e # || error.is_a?(SocketError)
        Rails.logger.debug "EnginesSystemApiResourceNotFoundError: #{e.inspect} #{e.response}"
        raise EnginesSystemApiResourceNotFoundError.new(e)
      rescue RestClient::Forbidden => e
        Rails.logger.debug "EnginesSystemApiConnectionAuthenticationError: #{e.inspect} #{e.response}"
        raise EnginesSystemApiConnectionAuthenticationError.new(@api_url)
      rescue RestClient::Exceptions::OpenTimeout => e
        Rails.logger.debug "EnginesSystemApiConnectionTimeoutError: #{e.inspect} #{e.response}"
        raise EnginesSystemApiConnectionTimeoutError
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
      end

      def get(api_route, opts)
        params = opts[:params] || {}

        parse api_call( :get, api_route, params ), opts[:expect]
      end

      def post(api_route, opts, file=nil)

        params = opts[:params] || {}
        parse api_call( :post, api_route, params, file ), opts[:expect]
      end

      def delete(api_route, opts)
        params = opts[:params] || {}
        parse api_call( :delete, api_route, params ), opts[:expect]
      end

      def parse(api_call_result, expected_content)
        byebug if Rails.env.development? && !( api_call_result.net_http_res.content_type != "application/json" || api_call_result.net_http_res.content_type != "text/plain" )
        result = api_call_result.body.to_s
        Rails.logger.info "Engines System API result: #{result}  result_class: #{result.class}"
        if api_call_result.net_http_res.content_type == "application/json" && expected_content == :json
          JSON.parse result, symbolize_names: true
        elsif api_call_result.net_http_res.content_type == "text/plain" && expected_content == :string
          if result[0] == '"' && result[-1] == '"'
            byebug if Rails.env.development?
            result[1..-2] # remove leading and trailing quotation marks
          else
            result
          end
        elsif api_call_result.net_http_res.content_type == "text/plain" && expected_content == :boolean
          result == 'true'
        elsif api_call_result.net_http_res.content_type == "text/plain" && expected_content == :file
          result
        else
          raise "Invalid content type. Expected #{expected_content} but received #{api_call_result.net_http_res.content_type}.\n\nResult #{result}"
        end
      rescue => error
        Rails.logger.warn "Engines System API result parse #{expected_content} failed: #{error}"
        raise EnginesSystemApiResponseError.new error
      end

    end
  end
end
