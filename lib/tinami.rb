# coding: utf-8

require 'tinami/client'
require 'tinami/configuration'

module TINAMI
  extend Configuration

  # Alias for TINAMI::Client.new
  #
  # @return [TINAMI::Client]
  def self.new(options = {})
    TINAMI::Client.new(options)
  end

  # Delegate to {TINAMI::Client}
  def self.method_missing(method_name, *args, &block)
    return super unless new.respond_to?(method_name)
    new.send(method_name, *args, &block)
  end

  # Delegate to {TINAMI::Client}
  def self.respond_to?(method_name, include_private = false)
    return new.respond_to?(method_name, include_private) || super
  end
end
