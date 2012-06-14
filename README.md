# XProxy

A Rack compatible HTTP Proxy. Useful for enabling JS to make requests to foreign domains.

Note: Currently XProxy sends back 'Access-Control-Allow-Origin: *' header to allow requests from any origin.  Hope to make this configurable for future releases.

## Installation

Add this line to your application's Gemfile:

    gem 'xproxy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xproxy

## Usage

```ruby
# config.ru
use XProxy::Proxy do
  match '/', :to => 'https://github.com/'
  match '/google', :to => 'http://www.google.com/'
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
