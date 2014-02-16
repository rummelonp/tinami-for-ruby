# coding: utf-8

require 'tinami/api'
require 'tinami/configuration'
require 'tinami/connection'
require 'tinami/request'

module TINAMI
  # Wrapper for the TINAMI REST API
  #
  # @see http://www.tinami.com/api/
  class Client
    include Connection
    include Request
    include API

    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(options = {})
      options = TINAMI.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
  end
end
