require 'restclient'
require 'active_support/core_ext/hash'
require 'hashie'

module TINAMI
  class Client
    attr_accessor *Configuration::OPTIONS_KEYS

    def initialize(options = {})
      options = TINAMI.options.merge(options)
      Configuration::OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    "
      auth                  /auth                          none     post
      info                  /login/info                    auth_key
      logout                /logout                        auth_key
      search                /content/search                none
      bookmark_contents     /bookmark/content/list         auth_key
      friend_recommends     /friend/recommend/content/list auth_key
      watchkeyword_contents /watchkeyword/content/list     auth_key
      collections           /collection/list               auth_key
      add_collection        /collection/add                auth_key
      bookmarks             /bookmark/list                 auth_key
      add_bookmark          /bookmark/add                  auth_key
      ranking               /ranking                       none
      content               /content/info                  none
      creator               /creator/info                  none
      comments              /content/comment/list          none
      add_comment           /content/comment/add           auth_key
      remove_comment        /content/comment/remove        auth_key
      support               /content/support               auth_key
    ".strip.split("\n").map {|l| l.strip.split(/\s+/)}.each do |api|
      method_name, path, auth, http_method = *api
      http_method ||= 'get'
      define_method method_name do |params = {}|
        params = key_params.merge(params)
        send http_method, path, params
      end
    end

    def key_params
      params = {api_key: api_key}
      params[:auth_key] = auth_key if auth_key
      params
    end

    def header
      {user_agent: user_agent}
    end

    def get(path, params)
      response = RestClient.get(endpoint + path, header.merge(params: params))
      parse_response(response)
    end

    def post(path, params)
      response = RestClient.post(endpoint + path, params, header)
      parse_response(response)
    end

    def parse_response(response)
      Hashie::Mash.new(Hash.from_xml(response))
    end
  end
end
