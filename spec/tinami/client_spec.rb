# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TINAMI::Client do
  before do
    TINAMI.configure do |config|
      config.api_key  = 'api_key'
    end
  end

  context :auth do
    before do
      @client = TINAMI::Client.new
    end

    it 'should respond to auth' do
      @client.should_receive(:post).with('/auth', api_key: 'api_key', email: 'email', password: 'password')
      @client.auth('email', 'password')
    end
  end

  context :api do
    before do
      @client = TINAMI::Client.new(auth_key: 'auth_key')
    end

    it 'should respond to info' do
      @client.should_receive(:get).with('/login/info', api_key: 'api_key', auth_key: 'auth_key')
      @client.info
    end

    it 'should respond to logout' do
      @client.should_receive(:get).with('/logout', api_key: 'api_key', auth_key: 'auth_key')
      @client.logout
    end

    it 'should respond to search' do
      @client.should_receive(:get).with('/content/search', api_key: 'api_key', auth_key: 'auth_key', text: 'keyword')
      @client.search(text: 'keyword')
    end

    it 'should respond to bookmark_contents' do
      @client.should_receive(:get).with('/bookmark/content/list', api_key: 'api_key', auth_key: 'auth_key')
      @client.bookmark_contents
    end

    it 'should respond to friend_recommenrds' do
      @client.should_receive(:get).with('/friend/recommend/content/list', api_key: 'api_key', auth_key: 'auth_key')
      @client.friend_recommends
    end

    it 'should respond to watchkeyword_contents' do
      @client.should_receive(:get).with('/watchkeyword/content/list', api_key: 'api_key', auth_key: 'auth_key')
      @client.watchkeyword_contents
    end

    it 'should respond to collections' do
      @client.should_receive(:get).with('/collection/list', api_key: 'api_key', auth_key: 'auth_key')
      @client.collections
    end

    it 'should respond to add_collection' do
      @client.should_receive(:get).with('/collection/add', api_key: 'api_key', auth_key: 'auth_key', cont_id: '1')
      @client.add_collection('1')
    end

    it 'should respond to bookmarks' do
      @client.should_receive(:get).with('/bookmark/list', api_key: 'api_key', auth_key: 'auth_key')
      @client.bookmarks
    end

    it 'should respond to add_bookmark' do
      @client.should_receive(:get).with('/bookmark/add', api_key: 'api_key', auth_key: 'auth_key', prof_id: '1')
      @client.add_bookmark('1')
    end

    it 'should respond to ranking' do
      @client.should_receive(:get).with('/ranking', api_key: 'api_key', auth_key: 'auth_key', category: '1')
      @client.ranking('1')
    end

    it 'should respond to content' do
      @client.should_receive(:get).with('/content/info', api_key: 'api_key', auth_key: 'auth_key', cont_id: '1')
      @client.content('1')
    end

    it 'should respond to creator' do
      @client.should_receive(:get).with('/creator/info', api_key: 'api_key', auth_key: 'auth_key', prof_id: '1')
      @client.creator('1')
    end

    it 'should respond to comments' do
      @client.should_receive(:get).with('/content/comment/list', api_key: 'api_key', auth_key: 'auth_key', cont_id: '1')
      @client.comments('1')
    end

    it 'should respond to add_comment' do
      @client.should_receive(:get).with('/content/comment/add', api_key: 'api_key', auth_key: 'auth_key', cont_id: '1', comment: 'comment')
      @client.add_comment('1', 'comment')
    end

    it 'should respond to remove_comment' do
      @client.should_receive(:get).with('/content/comment/remove', api_key: 'api_key', auth_key: 'auth_key', comment_id: '1')
      @client.remove_comment(comment_id: '1')
    end

    it 'should respond to support' do
      @client.should_receive(:get).with('/content/support', api_key: 'api_key', auth_key: 'auth_key', cont_id: '1')
      @client.support(cont_id: '1')
    end
  end

  context :error do
    before do
      @client = TINAMI::Client.new
    end

    def create_response(stat, content)
      {stat: stat}.merge(content).to_xml(root: :rsp)
    end

    it do
      lambda {
        response = create_response('fail', {err: {msg: 'auth_keyが指定されていません'}})
        @client.send(:parse_response, response)
      }.should raise_error(TINAMI::Error)
    end

    it do
      lambda {
        response = create_response('ok', {user: {no: 1}})
        @client.send(:parse_response, response)
      }.should_not raise_error(TINAMI::Error)
    end
  end
end
