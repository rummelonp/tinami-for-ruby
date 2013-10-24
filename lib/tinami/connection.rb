require 'faraday'
require 'faraday_middleware'

module TINAMI
  module Connection
    def connection(options = {})
      default_options = {
        :headers => {
          :accept => 'application/xml',
          :user_agent => user_agent,
        },
      }
      options = default_options.merge(options)
      Faraday::Connection.new(endpoint, options) do |builder|
        # TODO: raise error
        builder.response :mashify
        builder.response :xml
        builder.request :url_encoded
        builder.adapter :net_http
      end
    end
  end
end
