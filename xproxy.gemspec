# -*- encoding: utf-8 -*-
require File.expand_path('../lib/xproxy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Adam Jahn"]
  gem.email         = ["ajjahn@gmail.com"]
  gem.description   = %q{A Rack compatible HTTP Proxy}
  gem.summary       = %q{A Rack compatible HTTP Proxy}
  gem.homepage      = "https://github.com/ajjahn/xproxy"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "xproxy"
  gem.require_paths = ["lib"]
  gem.version       = XProxy::VERSION
  
  gem.add_development_dependency 'rake'
  
  gem.add_dependency 'rack', '~> 1.4.1'
  gem.add_dependency 'rackheader', '~> 0.0.1'
  gem.add_dependency 'rackproxy', '~> 0.0.2'
end
