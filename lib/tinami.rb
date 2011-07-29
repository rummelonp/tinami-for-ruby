require "tinami/configuration"
require "tinami/client"
require "tinami/version"

module TINAMI
  extend self
  extend TINAMI::Configuration

  def client(options = {})
    TINAMI::Client.new(options)
  end
end
