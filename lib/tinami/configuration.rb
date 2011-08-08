module TINAMI
  # Defines constants and methods related to configuration
  module Configuration
    # An array of keys in the options hash when configuring a {TINAMI::API}
    OPTIONS_KEYS = [
      :api_key,
      :auth_key,
      :endpoint,
      :user_agent
    ].freeze

    # By default, don't set an application api key
    DEFAULT_API_KEY    = nil

    # By default, don't set an user auth key
    DEFAULT_AUTH_KEY   = nil

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    DEFAULT_ENDPOINT   = 'http://api.tinami.com'.freeze

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = 'TINAMI Ruby Gem'.freeze

    # @private
    attr_accessor *OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      OPTIONS_KEYS.inject({}) do |options, key|
        options.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.api_key    = DEFAULT_API_KEY
      self.auth_key   = DEFAULT_AUTH_KEY
      self.endpoint   = DEFAULT_ENDPOINT
      self.user_agent = DEFAULT_USER_AGENT
    end
  end
end
