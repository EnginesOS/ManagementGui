module EnginesSystemCore
  module CoreApi
    module ApiCall

      private

      def get(api_route, opts)
        # params = opts[:params] || {}
        api_call_opts = { timeout: opts[:timeout] }
        parse api_call( :get, api_route, api_call_opts ), opts[:expect]
      end

      def post(api_route, opts)
        api_call_opts = { timeout: opts[:timeout],
                          payload: { api_vars: opts[:params] }.to_json,
                          content_type: 'application/json' }
puts "=============================================="
puts "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv"
puts "PARSE JSON and output cert using JSON.parse(api_call_opts[:payload], symbolize_names: true)[:api_vars][:certificate] "
puts api_call_opts[:payload]
puts JSON.parse(api_call_opts[:payload], symbolize_names: true)[:api_vars][:certificate]
puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
puts "=============================================="


        parse api_call( :post, api_route, api_call_opts ), opts[:expect]
      end

      def put_file(api_route, opts)
        api_call_opts = { timeout: opts[:timeout],
                          payload: opts[:file],
                          content_type: 'application/octet-stream' }
        parse api_call( :put, api_route, api_call_opts ), opts[:expect]
      end

      def delete(api_route, opts)
        api_call_opts = { timeout: opts[:timeout] }
        parse api_call( :delete, api_route, api_call_opts ), opts[:expect]
      end

      def api_call(http_method, api_route, opts={})
        timeout = ( opts[:timeout] || 30 )
        if http_method == :post || http_method == :put
          payload = opts[:payload]
          content_type = opts[:content_type]
          Rails.logger.debug "#{http_method} api_route: #{@system_url}/v0/#{api_route}, payload #{payload.class}: #{payload}, access_token: #{@token}"
          result = RestClient::Request.execute(method: http_method, url: "#{@system_url}/v0/#{api_route}", payload: payload, timeout: timeout, open_timeout: timeout, verify_ssl: false, headers: { content_type: content_type, access_token: @token } ) # , content_type: :json )
        else
          Rails.logger.debug "#{http_method} api_route: #{@system_url}/v0/#{api_route}, access_token: #{@token}"
          # RestClient::Request.execute(method: http_method, url: "#{@system_url}/v0/#{api_route}", timeout: timeout, open_timeout: timeout, headers: { params: payload, access_token: @token } ) #, verify_ssl: false, content_type: :json )
          result = RestClient::Request.execute(method: http_method, url: "#{@system_url}/v0/#{api_route}", timeout: timeout, open_timeout: timeout, verify_ssl: false, headers: { access_token: @token } ) #, verify_ssl: false, content_type: :json )
        end
        # .tap { |result| Rails.logger.debug "#{http_method} api_route: #{@system_url}/v0/#{api_route}\nresult:\n#{result}" }
        Rails.logger.debug "#{http_method} api_route: #{@system_url}/v0/#{api_route}\nresult:\n#{result}"
        result
      rescue RestClient::NotFound => e
        raise EnginesError.new "Failed to load the requested resource on Engines system #{@name} at #{@system_url}.\n\n#{system_error_message_from(e)}"
      rescue URI::InvalidURIError # normally thrown when user enters an invalid url for an engines system.
        raise EnginesError.new "Invalid URL for Engines system #{@name} at #{@system_url}."
      rescue SocketError # normally thrown when user enters an invalid url for an engines system.
        raise EnginesError.new "There was an error connecting to the Engines system #{@name} at #{@system_url}. Please check system URL."
      rescue OpenSSL::SSL::SSLError => e # normally throw when SSL certificate is invalid.
        raise EnginesError.new "The security certificate is invalid for Engines system #{@name} at #{@system_url}."
      rescue RestClient::SSLCertificateNotVerified
        raise EnginesError.new "The security certificate is not trusted for Engines system #{@name} at #{@system_url}."
      rescue Errno::EHOSTUNREACH, Errno::ENETUNREACH # normally thrown when there is a routing or network problem.
        raise EnginesError::ApiConnectionError.new "Cannot establish connection to Engines system #{@name} at #{@system_url}."
      rescue Errno::ECONNREFUSED => e # normally thrown when system is offline.
        raise EnginesError::ApiConnectionError.new "Connection refused to Engines system #{@name} at #{@system_url}."
      rescue Errno::ECONNRESET => e # normally thrown after system update.
        raise EnginesError::ApiConnectionError.new "Connection has been reset to Engines system #{@name} at #{@system_url}."
      rescue RestClient::ServerBrokeConnection => e  # normally thrown when the system has been online and then goes offline (when system stopped, for example).
        raise EnginesError::ApiConnectionError.new "Connection has been broken to Engines system #{@name} at #{@system_url} ."
      rescue RestClient::Exceptions::OpenTimeout, RestClient::Exceptions::ReadTimeout => e
        raise EnginesError::ApiConnectionError.new "The connection has timed-out to Engines system #{@name} at #{@system_url}."
      rescue RestClient::Forbidden => e # can't authenticate. Throwing custom error so that gui knows to present authentication link
        raise EnginesError::ApiConnectionAuthenticationError.new "Failed to authenticate the connection with the Engines system."
      rescue => e
        Rails.logger.debug \
        "++++++++\n"\
        "UNHANDLED ENGINES API ERROR in EnginesSystemCore::CoreApi::ApiCall.api_call\n"\
        "api call: #{http_method} #{api_route} #{payload}\n"\
        ">>>>> e.class: #{e.class}\n"\
        ">>>>> e.response: #{e.try(:response) || 'n/a'}\n"\
        ">>>>> e.inspect: #{e.inspect}\n"\
        "++++++++"
        raise
      ensure
        Rails.logger.debug "#{http_method} api_route: #{@system_url}/v0/#{api_route} - done"
      end

      def parse(api_call_result, expected_content)
        result = api_call_result.body.to_s
        if api_call_result.net_http_res.content_type == "application/json" && expected_content == :json
          begin
            JSON.parse result, symbolize_names: true
          rescue
            raise EnginesError::ApiParseError.new "Failed to parse JSON.", result
          end
        elsif api_call_result.net_http_res.content_type == "text/plain" && expected_content == :plain_text
          result
        elsif api_call_result.net_http_res.content_type == "text/plain" && expected_content == :boolean
          result == 'true'
        elsif ( api_call_result.net_http_res.content_type == "text/plain" || api_call_result.net_http_res.content_type == "application/octet-stream" ) && expected_content == :file
          result
        else
          raise EnginesError::ApiParseError.new "Invalid content type. Expected #{expected_content} #{expected_content.class} but received #{api_call_result.net_http_res.content_type} #{api_call_result.net_http_res.content_type.class}.", result
        end
      rescue => e
        Rails.logger.debug "Engines System API result parse #{expected_content} failed: #{e}"
        raise e
      end

      def system_error_message_from(e)
        JSON.parse(e.response, symbolize_names: true)[:error_object][:error_mesg] || raise
      rescue
        "Failed to extract system error message from API response."
      end

    end
  end
end

# module EnginesSystemCore
#   module CoreApi
#     module ApiCall
#
#       private
#
#       def get(api_path, opts)
#         # params = opts[:params] || {}
#         api_call_opts = { timeout: opts[:timeout] }
#         parse api_call( :get, api_path, api_call_opts ), opts[:expect]
#       end
#
#       def post(api_path, opts)
#         api_call_opts = { timeout: opts[:timeout],
#                           payload: { api_vars: opts[:params] }.to_json,
#                           content_type: 'application/json' }
#         parse api_call( :post, api_path, api_call_opts ), opts[:expect]
#       end
#
#       def put_file(api_path, opts)
#         api_call_opts = { timeout: opts[:timeout],
#                           payload: opts[:file],
#                           content_type: 'application/octet-stream' }
#         parse api_call( :put, api_path, api_call_opts ), opts[:expect]
#       end
#
#       def delete(api_path, opts)
#         api_call_opts = { timeout: opts[:timeout] }
#         parse api_call( :delete, api_path, api_call_opts ), opts[:expect]
#       end
#
#       def api_call(http_method, api_path, opts={})
#         timeout = ( opts[:timeout] || 10 )
#         if http_method == :post || http_method == :put
#           payload = opts[:payload]
#           content_type = opts[:content_type]
#           Rails.logger.debug "#{http_method} api_path: #{@system_url}/v0/#{api_path}, payload #{payload.class}: #{payload}, access_token: #{@token}"
#           result = RestClient::Request.execute(method: http_method, url: "#{@system_url}/v0/#{api_path}", payload: payload, timeout: timeout, open_timeout: timeout, verify_ssl: false, headers: { content_type: content_type, access_token: @token } ) # , content_type: :json )
#         else
#           Rails.logger.debug "#{http_method} api_path: #{@system_url}/v0/#{api_path}, access_token: #{@token}"
#           # RestClient::Request.execute(method: http_method, url: "#{@system_url}/v0/#{api_path}", timeout: timeout, open_timeout: timeout, headers: { params: payload, access_token: @token } ) #, verify_ssl: false, content_type: :json )
#           result = RestClient::Request.execute(method: http_method, url: "#{@system_url}/v0/#{api_path}", timeout: timeout, open_timeout: timeout, verify_ssl: false, headers: { access_token: @token } ) #, verify_ssl: false, content_type: :json )
#         end
#         # .tap { |result| Rails.logger.debug "#{http_method} api_path: #{@system_url}/v0/#{api_path}\nresult:\n#{result}" }
#         Rails.logger.debug "#{http_method} api_path: #{@system_url}/v0/#{api_path}\nresult:\n#{result}"
#         result
#       rescue RestClient::NotFound => e
#         raise EnginesError.new "Failed to load the requested resource on Engines system #{@name} at #{@system_url}.\n\n#{system_error_message_from(e)}"
#       rescue URI::InvalidURIError # normally thrown when user enters an invalid url for an engines system.
#         raise EnginesError.new "Invalid URL for Engines system #{@name} at #{@system_url}."
#       # rescue OpenSSL::SSL::SSLError => e # normally throw when SSL certificate is invalid.
#       #   raise EnginesError.new "The security certificate is invalid for Engines system #{@name} at #{@system_url}."
#       rescue RestClient::SSLCertificateNotVerified
#         raise EnginesError.new "The security certificate is not trusted for Engines system #{@name} at #{@system_url}."
#       rescue Errno::EHOSTUNREACH, Errno::ENETUNREACH # normally thrown when there is a routing or network problem.
#         raise EnginesError::ApiConnectionError.new "Cannot establish connection to Engines system #{@name} at #{@system_url}."
#       rescue Errno::ECONNREFUSED => e # normally thrown when system is offline.
#         raise EnginesError::ApiConnectionError.new "Connection refused to Engines system #{@name} at #{@system_url}."
#       rescue Errno::ECONNRESET => e # normally thrown after system update.
#         raise EnginesError::ApiConnectionError.new "Connection has been reset to Engines system #{@name} at #{@system_url}."
#       rescue RestClient::ServerBrokeConnection => e  # normally thrown when the system has been online and then goes offline (when system stopped, for example).
#         raise EnginesError::ApiConnectionError.new "Connection has been broken to Engines system #{@name} at #{@system_url} ."
#       rescue RestClient::Exceptions::OpenTimeout, RestClient::Exceptions::ReadTimeout => e
#         raise EnginesError::ApiConnectionError.new "The connection has timed-out to Engines system #{@name} at #{@system_url}."
#       rescue RestClient::Forbidden => e # can't authenticate. Throwing custom error so that gui knows to present authentication link
#         raise EnginesError::ApiConnectionAuthenticationError.new "Failed to authenticate the connection with the Engines system."
#       rescue => e
#         Rails.logger.debug \
#         "++++++++\n"\
#         "UNHANDLED ENGINES API ERROR in EnginesSystemCore::CoreApi::ApiCall.api_call\n"\
#         "api call: #{http_method} #{api_path} #{payload}\n"\
#         ">>>>> e.class: #{e.class}\n"\
#         ">>>>> e.response: #{e.try(:response) || 'n/a'}\n"\
#         ">>>>> e.inspect: #{e.inspect}\n"\
#         "++++++++"
#         raise
#       ensure
#         Rails.logger.debug "#{http_method} api_path: #{@system_url}/v0/#{api_path} - done"
#       end
#
#       def parse(api_call_result, expected_content)
#         result = api_call_result.body.to_s
#         if api_call_result.net_http_res.content_type == "application/json" && expected_content == :json
#           begin
#             JSON.parse result, symbolize_names: true
#           rescue
#             raise EnginesError::ApiParseError.new "Failed to parse JSON.", result
#           end
#         elsif api_call_result.net_http_res.content_type == "text/plain" && expected_content == :plain_text
#           result
#         elsif api_call_result.net_http_res.content_type == "text/plain" && expected_content == :boolean
#           result == 'true'
#         elsif ( api_call_result.net_http_res.content_type == "text/plain" || api_call_result.net_http_res.content_type == "application/octet-stream" ) && expected_content == :file
#           result
#         else
#           raise EnginesError::ApiParseError.new "Invalid content type. Expected #{expected_content} #{expected_content.class} but received #{api_call_result.net_http_res.content_type} #{api_call_result.net_http_res.content_type.class}.", result
#         end
#       rescue => e
#         Rails.logger.debug "Engines System API result parse #{expected_content} failed: #{e}"
#         raise e
#       end
#
#       def system_error_message_from(e)
#         JSON.parse(e.response, symbolize_names: true)[:error_object][:error_mesg] || raise
#       rescue
#         "Failed to extract system error message from API response."
#       end
#
#     end
#   end
# end
