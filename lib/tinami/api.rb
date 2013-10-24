require 'faraday'
require 'faraday_middleware'
require 'tinami/error'

module TINAMI
  # @private
  class API
    # @private
    attr_accessor *Configuration::OPTIONS_KEYS

    # Creates a new API
    def initialize(options = {})
      options = TINAMI.options.merge(options)
      Configuration::OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    # Perform an HTTP GET request
    def get(path, params = {})
      request(:get, path, params)
    end

    # Perform an HTTP POST request
    def post(path, params = {})
      request(:post, path, params)
    end

    # Perform an HTTP request
    def request(http_method, path, params = {})
      response = connection.send(http_method) do |request|
        case http_method
        when :get, :delete
          request.url(path, params)
        when :post, :put
          request.path = path
          request.body = params unless params.empty?
        end
      end
      response.body.rsp
    end

    def connection
      options = {
        :headers => {
          :accept => 'application/xml',
          :user_agent => user_agent,
        },
      }

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
