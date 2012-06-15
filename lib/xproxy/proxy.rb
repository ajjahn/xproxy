require 'net/http'
require 'rack/request'

module XProxy
  class Proxy

      def initialize(app, &block)
        @app = app
        @map = XProxy::Map.new
        @map.instance_exec(&block) if block_given?
      end

      def call(env)
        request = Rack::Request.new(env)
        
        return @app.call(env) unless uri = @map.translate(URI(request.url))
              
        # Get the request method
        request_method = request.request_method.downcase
        request_method[0..0] = request_method[0..0].upcase

        forward_request = Net::HTTP.const_get(request_method).new(uri.request_uri)
        if forward_request.request_body_permitted? and request.body
          forward_request.body_stream = request.body
          forward_request.content_length = request.content_length
          forward_request.content_type = request.content_type
        end

        forward_request["Referer"] = request.referer

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == 'https' ? true : false
        forward_response = http.request(forward_request)

        headers = {}
        forward_response.each_header do |k,v|
          headers[k] = v unless k.to_s =~ /status/i
        end
        headers['Access-Control-Allow-Origin'] = '*'

        [forward_response.code.to_i, headers, [forward_response.read_body]]
      end
  end
end