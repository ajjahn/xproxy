require 'rack/header'
require 'rack/proxy'

module XProxy
  class Application
    def initialize(host, headers)
      @host, @headers = host, headers
    end
    
    def call(env)      
      host, headers = @host, @headers
      
      app = Rack::Builder.new do
        use Rack::Header, headers        
        run Rack::Proxy.new(host)
      end
      
      app.call(env)
    end
  end
end