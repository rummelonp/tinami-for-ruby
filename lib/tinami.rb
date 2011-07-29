require "tinami/configuration"
require "tinami/client"
require "tinami/error"
require "tinami/version"

module TINAMI
  extend self
  extend TINAMI::Configuration

  def client(options = {})
    TINAMI::Client.new(options)
  end

  def method_missing(method_name, *args, &block)
    return super unless client.respond_to?(method_name)
    client.send(method_name, *args, &block)
  end

  def respond_to?(method_name)
    return client.respond_to?(method_name) || super
  end
end
