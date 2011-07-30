module TINAMI
  module Configuration
    OPTIONS_KEYS = [
      :api_key,
      :auth_key,
      :endpoint,
      :user_agent
    ].freeze

    DEFAULT_API_KEY    = nil
    DEFAULT_AUTH_KEY   = nil
    DEFAULT_ENDPOINT   = 'http://api.tinami.com'.freeze
    DEFAULT_USER_AGENT = 'TINAMI Ruby Gem'.freeze

    attr_accessor *OPTIONS_KEYS

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      OPTIONS_KEYS.inject({}) do |options, key|
        options.merge!(key => send(key))
      end
    end

    def reset
      self.api_key    = DEFAULT_API_KEY
      self.auth_key   = DEFAULT_AUTH_KEY
      self.endpoint   = DEFAULT_ENDPOINT
      self.user_agent = DEFAULT_USER_AGENT
    end
  end
end
