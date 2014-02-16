
module TINAMI
  module API
    # @authentication API Key
    # @param email [String]
    # @param password [String]
    # @return [Hashie::Mash]
    def auth(email, password)
      post('auth', api_keys.merge(email: email, password: password))
    end

    # @authentication Auth Key
    # @return [Hashie::Mash]
    def info
      get('login/info', auth_keys)
    end

    # @authentication Auth Key
    # @return [Hashie::Mash]
    def logout
      get('logout', auth_keys)
    end

    # @authentication API Key
    # @param params [Hash]
    # @option params [String] :text
    # @option params [String] :tag
    # @option params [String] :search
    # @option params [String] :sort
    # @option params [Array<Integer>] :cont_type
    # @option params [Integer] :page (1)
    # @option params [Integer] :perpage (20)
    # @option params [Integer] :prof_id
    # @option params [Integer] :safe
    # @return [Hashie::Mash]
    def search(params = {})
      get('content/search', auth_keys.merge(params))
    end

    # @authentication Auth Key
    # @param params [Hash]
    # @option params [Integer] :page (1)
    # @option params [Integer] :perpage (20)
    # @option params [Integer] :safe
    # @return [Hashie::Mash]
    def bookmark_contents(params = {})
      get('bookmark/content/list', auth_keys.merge(params))
    end

    # @authentication Auth Key
    # @param params [Hash]
    # @option params [Integer] :page (1)
    # @option params [Integer] :perpage (20)
    # @option params [Integer] :safe
    # @return [Hashie::Mash]
    def friend_recommends(params = {})
      get('friend/recommend/content/list', auth_keys.merge(params))
    end

    # @authentication Auth Key
    # @param params [Hash]
    # @option params [Integer] :page (1)
    # @option params [Integer] :perpage (20)
    # @option params [Integer] :safe
    # @return [Hashie::Mash]
    def watchkeyword_contents(params = {})
      get('watchkeyword/content/list', auth_keys.merge(params))
    end

    # @authentication Auth Key
    # @param params [Hash]
    # @option params [Integer] :page (1)
    # @option params [Integer] :perpage (20)
    # @option params [Integer] :safe
    # @return [Hashie::Mash]
    def collections(params = {})
      get('collection/list', auth_keys.merge(params))
    end

    # @authentication Auth Key
    # @param cont_id [Integer]
    # @return [Hashie::Mash]
    def add_collection(cont_id)
      get('collection/add', auth_keys.merge(cont_id: cont_id))
    end

    # @authentication Auth Key
    # @param params [Hash]
    # @option params [Integer] :page (1)
    # @option params [Integer] :perpage (20)
    # @return [Hashie::Mash]
    def bookmarks(params = {})
      get('bookmark/list', auth_keys.merge(params))
    end

    # @authentication Auth Key
    # @param prof_id [Integer]
    # @return [Hashie::Mash]
    def add_bookmark(prof_id)
      get('bookmark/add', auth_keys.merge(prof_id: prof_id))
    end

    # @authentication API Key
    # @param category [Integer]
    # @return [Hashie::Mash]
    def ranking(category)
      get('ranking', auth_keys.merge(category: category))
    end

    # @authentication API Key
    # @param cont_id [Integer]
    # @param params [Hash]
    # @option params [Integer] :dates
    # @option params [Integer] :models
    # @return [Hashie::Mash]
    def content(cont_id, params = {})
      get('content/info', auth_keys.merge(params).merge(cont_id: cont_id))
    end

    # @authentication API Key
    # @param prof_id [Integer]
    # @return [Hashie::Mash]
    def creator(prof_id)
      get('creator/info', auth_keys.merge(prof_id: prof_id))
    end

    # @authentication API Key
    # @param cont_id [Integer]
    # @return [Hashie::Mash]
    def comments(cont_id)
      get('content/comment/list', auth_keys.merge(cont_id: cont_id))
    end

    # @authentication Auth Key
    # @param cont_id [Integer]
    # @param comment [String]
    # @return [Hashie::Mash]
    def add_comment(cont_id, comment)
      get('content/comment/add', auth_keys.merge(cont_id: cont_id, comment: comment))
    end

    # @authentication Auth Key
    # @param comment_id [Integer]
    # @return [Hashie::Mash]
    def remove_comment(comment_id)
      get('content/comment/remove', auth_keys.merge(comment_id: comment_id))
    end

    # @authentication Auth Key
    # @param cont_id [Integer]
    # @return [Hashie::Mash]
    def support(cont_id)
      get('content/support', auth_keys.merge(cont_id: cont_id))
    end

    private

    def api_keys
      params = {}
      params[:api_key] = api_key if api_key
      params
    end

    def auth_keys
      params = {}
      params[:api_key] = api_key if api_key
      params[:auth_key] = auth_key if auth_key
      params
    end
  end
end
