require 'tinami/configuration'
require 'tinami/connection'
require 'tinami/request'

module TINAMI
  # Wrapper for the TINAMI REST API
  class Client
    include Connection
    include Request

    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(options = {})
      options = TINAMI.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    # method name,          path for API,           authentication, http method
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
      define_method method_name do |*args|
        params = args.pop || {}
        params = keys_params.merge(params)
        send(http_method, path, params)
      end
    end

    alias_method :__auth, :auth
    def auth(email, password)
      __auth(:email => email, :password => password)
    end

    alias_method :__add_collection, :add_collection
    def add_collection(cont_id)
      __add_collection(:cont_id => cont_id)
    end

    alias_method :__add_bookmark, :add_bookmark
    def add_bookmark(prof_id)
      __add_bookmark(:prof_id => prof_id)
    end

    alias_method :__ranking, :ranking
    def ranking(category)
      __ranking(:category => category)
    end

    alias_method :__content, :content
    def content(cont_id)
      __content(:cont_id => cont_id)
    end

    alias_method :__creator, :creator
    def creator(prof_id)
      __creator(:prof_id => prof_id)
    end

    alias_method :__comments, :comments
    def comments(cont_id)
      __comments(:cont_id => cont_id)
    end

    alias_method :__add_comment, :add_comment
    def add_comment(cont_id, comment)
      __add_comment(:cont_id => cont_id, :comment => comment)
    end

    alias_method :__remove_comment, :remove_comment
    def remove_comment(comment_id)
      __remove_comment(:comment_id => comment_id)
    end

    alias_method :__support, :support
    def support(cont_id)
      __support(:cont_id => cont_id)
    end

    private
    def keys_params
      params = {}
      params[:api_key] = api_key if api_key
      params[:auth_key] = auth_key if auth_key
      params
    end
  end
end
