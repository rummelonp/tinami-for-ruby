# coding: utf-8

require 'spec_helper'

describe TINAMI::Client do
  context 'with module configuration' do
    let(:keys) { TINAMI::Configuration::VALID_OPTIONS_KEYS }

    before do
      TINAMI.configure do |config|
        keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      TINAMI.reset
    end

    it 'should inherit module configuration' do
      client = TINAMI::Client.new
      keys.each do |key|
        expect(client.send(key)).to eql(key)
      end
    end

    context 'with class configuration' do
      let(:configuration) do
        {
          adapter: :typhoeus,
          api_key: 'AK',
          auth_key: 'AK',
          endpoint: 'https://api.twitter.com',
          proxy: 'http://mitukiii:secret@proxy.example.com:8080',
          user_agent: 'Custom User Agent'
        }
      end

      context 'during initialization' do
        it 'should override module configuration' do
          client = TINAMI::Client.new(configuration)
          keys.each do |key|
            expect(client.send(key)).to eql(configuration[key])
          end
        end
      end

      context 'after initilization' do
        it 'should override module configuration after initialization' do
          client = TINAMI::Client.new
          configuration.each do |key, value|
            client.send("#{key}=", value)
          end
          keys.each do |key|
            expect(client.send(key)).to eql(configuration[key])
          end
        end
      end
    end
  end

  context 'when have error' do
    let(:api_key) { 'api_key' }
    let(:client) { TINAMI::Client.new(api_key: api_key) }

    def create_xml(stat, msg = nil)
      xml = <<-XML
        <?xml version="1.0" encoding="utf-8"?>
        <rsp stat="#{stat}">
          <err msg="#{msg}" />
        </rsp>
      XML
    end

    it do
      stub_get('content/info')
        .with(query: {api_key: api_key, cont_id: 1})
        .to_return(status: 200, body: create_xml('fail', 'APIキーが指定されていないか、値が不正です'))
      expect { client.content('1') }.to raise_error(TINAMI::FailError)
    end

    it do
      stub_get('content/info')
        .with(query: {api_key: api_key, cont_id: 1})
        .to_return(status: 200, body: create_xml('fail'))
      expect { client.content('1') }.to raise_error(TINAMI::FailError)
    end

    it do
      stub_get('content/info')
        .with(query: {api_key: api_key, cont_id: 1})
        .to_return(status: 200, body: create_xml('user_only', 'この作品は登録ユーザー限定の作品です'))
      expect { client.content('1') }.to raise_error(TINAMI::UserOnlyError)
    end

    it do
      stub_get('content/info')
        .with(query: {api_key: api_key, cont_id: 1})
        .to_return(status: 200, body: create_xml('bookmark_user_only', 'この作品はお気に入りユーザー限定の作品です'))
      expect { client.content('1') }.to raise_error(TINAMI::BookmarkUserOnlyError)
    end

    it do
      stub_get('content/info')
        .with(query: {api_key: api_key, cont_id: 1})
        .to_return(status: 200, body: create_xml('unknown', 'unknown error'))
      expect { client.content('1') }.to raise_error(TINAMI::Error)
    end

    it do
      xml = <<-XML
        <?xml version="1.0" encoding="utf-8"?>
        <rsp stat="ok">
          <user no="1" />
        </rsp>
      XML
      stub_get('content/info')
        .with(query: {api_key: api_key, cont_id: 1})
        .to_return(status: 200, body: xml)
      expect { client.content('1') }.to_not raise_error
    end
  end
end
