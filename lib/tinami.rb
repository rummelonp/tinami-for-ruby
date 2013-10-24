require 'tinami/client'
require 'tinami/configuration'
require 'tinami/version'

module TINAMI
  extend TINAMI::Configuration

  # Alias for TINAMI::Client.new
  #
  # @return [TINAMI::Client]
  def self.client(options = {})
    TINAMI::Client.new(options)
  end

  # Delegate to {TINAMI::Client}
  def self.method_missing(method_name, *args, &block)
    return super unless client.respond_to?(method_name)
    client.send(method_name, *args, &block)
  end

  # Delegate to {TINAMI::Client}
  def self.respond_to?(method_name, include_private = false)
    return client.respond_to?(method_name, include_private) || super
  end
end
