require 'xproxy/version'
require 'xproxy/application'

module XProxy
  def self.new(*args, &block)
    Application.new(*args, &block)
  end
end