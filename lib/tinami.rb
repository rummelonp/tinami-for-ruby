require "tinami/client"
require "tinami/version"

module TINAMI
  extend self

  def client(options = {})
    TINAMI::Client.new(options)
  end
end
