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
      response = RestClient.get(endpoint + path, header.merge(params: params))
      parse_response(response)
    end

    # Perform an HTTP POST request
    def post(path, params = {})
      response = RestClient.post(endpoint + path, params, header)
      parse_response(response)
    end

    private
    def header
      {user_agent: user_agent}
    end

    def parse_response(response)
      xml = Hashie::Mash.new(Hash.from_xml(response))
      case xml.rsp.stat
      when 'fail'
        raise Error.new(xml.rsp.err.msg, response)
      else
        xml.rsp
      end
    end
  end
end
