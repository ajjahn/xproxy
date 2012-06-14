require 'net/http'

module XProxy
  class Map < Hash
    
    def match(path, options={})
      self[path] = options
    end
    
    def translate(request)
      request_path = normalize_path(request.path)
      uri = nil
      each do |match_path, options|
        match_path = normalize_path(match_path)
        
        puts request_path
        
        if request_path.start_with?(match_path)
          request.path = options[:include_match] ? request.path : strip_match(request.path, match_path)
          uri = translate_uri(URI(options[:to]), request)
        end
      end
      
      uri
    end
    
  private
    
    def normalize_path(path)
      "/#{path.split('/').delete_if(&:empty?).join('/')}"
    end
    
    def strip_match(request_path, match_path)
      normalize_path(request_path.gsub(match_path, ''))
    end
    
    def translate_uri(to ,from)
      to.path = from.path
      to.opaque = from.opaque
      to.query = from.query
      to.fragment = from.fragment
      
      to
    end
  end
end