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
      response = RestClient.get(endpoint + path, header.merge(:params => params))
      parse_response(response)
    end

    # Perform an HTTP POST request
    def post(path, params = {})
      response = RestClient.post(endpoint + path, params, header)
      parse_response(response)
    end

    private
    def header
      {:user_agent => user_agent}
    end

    def parse_response(response)
      xml = Hashie::Mash.new(Hash.from_xml(response))
      res = xml.rsp
      if res.stat != 'ok' || res.err
        case res.stat
        when 'fail'
          error_class = FailError
        when 'user_only'
          error_class = UserOnlyError
        when 'bookmark_user_only'
          error_class = BookmarkUserOnlyError
        else
          error_class = Error
        end
        msg = res.err ? res.err.msg : nil
        raise error_class.new(msg, response)
      else
        res
      end
    end
  end
end
