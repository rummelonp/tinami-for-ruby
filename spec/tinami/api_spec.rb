# coding: utf-8

require 'spec_helper'

describe TINAMI::API do
  let(:api_key) { 'api_key' }
  let(:auth_key) { 'auth_key' }

  context :auth do
    let(:client) { TINAMI.new(api_key: api_key) }

    describe '#auth' do
      it 'should request the correct resource' do
        stub_post('auth')
          .with(body: {api_key: 'api_key', email: 'email', password: 'password'})
        client.auth('email', 'password')
      end
    end
  end

  context :api do
    let(:client) { TINAMI.new(api_key: api_key, auth_key: auth_key) }

    describe '#auth' do
      it 'should request the correct resource' do
        stub_get('login/info')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key'})
        client.info
      end
    end

    describe '#logout' do
      it 'should request the correct resource' do
        stub_get('logout')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key'})
        client.logout
      end
    end

    describe '#search' do
      it 'should request the correct resource' do
        stub_get('content/search')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key', text: 'keyword'})
        client.search(text: 'keyword')
      end
    end

    describe '#bookmark_contents' do
      it 'should request the correct resource' do
        stub_get('bookmark/content/list')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key'})
        client.bookmark_contents
      end
    end

    describe '#friend_recommenrds' do
      it 'should request the correct resource' do
        stub_get('friend/recommend/content/list')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key'})
        client.friend_recommends
      end
    end

    describe '#watchkeyword_contents' do
      it 'should request the correct resource' do
        stub_get('watchkeyword/content/list')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key'})
        client.watchkeyword_contents
      end
    end

    describe '#collections' do
      it 'should request the correct resource' do
        stub_get('collection/list')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key'})
        client.collections
      end
    end

    describe '#add_collection' do
      it 'should request the correct resource' do
        stub_get('collection/add')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key', cont_id: '1'})
        client.add_collection('1')
      end
    end

    describe '#bookmarks' do
      it 'should request the correct resource' do
        stub_get('bookmark/list')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key'})
        client.bookmarks
      end
    end

    describe '#add_bookmark' do
      it 'should request the correct resource' do
        stub_get('bookmark/add')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key', prof_id: '1'})
        client.add_bookmark('1')
      end
    end

    describe '#ranking' do
      it 'should request the correct resource' do
        stub_get('ranking')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key', category: '1'})
        client.ranking('1')
      end
    end

    describe '#content' do
      it 'should request the correct resource' do
        stub_get('content/info')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key', cont_id: '1'})
        client.content('1')
      end
    end

    describe '#creator' do
      it 'should request the correct resource' do
        stub_get('creator/info')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key', prof_id: '1'})
        client.creator('1')
      end
    end

    describe '#comments' do
      it 'should request the correct resource' do
        stub_get('content/comment/list')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key', cont_id: '1'})
        client.comments('1')
      end
    end

    describe '#add_comment' do
      it 'should request the correct resource' do
        stub_get('content/comment/add')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key', cont_id: '1', comment: 'comment'})
        client.add_comment('1', 'comment')
      end
    end

    describe '#remove_comment' do
      it 'should request the correct resource' do
        stub_get('content/comment/remove')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key', comment_id: '1'})
        client.remove_comment('1')
      end
    end

    describe '#support' do
      it 'should request the correct resource' do
        stub_get('content/support')
          .with(query: {api_key: 'api_key', auth_key: 'auth_key', cont_id: '1'})
        client.support('1')
      end
    end
  end
end
