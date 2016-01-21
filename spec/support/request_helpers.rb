module Request
  module JsonHelpers
    def json_response
      @sjon_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module HeadersHelpers
    def api_header(version = 1)
      request.headers['Accept'] = "application/vnd.locket_server.v#{version}"
    end

    def api_response_format(format = Mime::JSON)
      request.headers['Accept' ] = "#{request.headers['Accept']}, #{format}"
      request.headers['Content-Type'] = format.to_s
    end

    def api_authorization_header(token)
      request.headers['Authorization' ] = token
    end

    def view_response_format(format = :html)
      request.headers['Accept' ] = :html
    end

    def include_default_accept_headers
      api_header
      api_response_format
    end
  end
end
