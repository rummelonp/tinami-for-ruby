# coding: utf-8

require 'spec_helper'

describe TINAMI do
  after do
    TINAMI.reset
  end

  context 'when delegating to a client' do
    let(:xml) do
      <<-XML
        <?xml version="1.0" encoding="utf-8"?>
        <rsp stat="ok" />
      XML
    end

    before do
      stub_get('content/info')
        .with(query: {cont_id: 1})
        .to_return(body: xml)
    end

    it 'should request the correct resource' do
      TINAMI.content(1)
    end

    it 'should return the same results as a client' do
      expect(TINAMI.content(1)).to eql(TINAMI::Client.new.content(1))
    end
  end

  describe '.new' do
    it 'should return a TINAMI::Client' do
      expect(TINAMI.new).to be_is_a(TINAMI::Client)
    end
  end

  describe '.respond_to?' do
    it 'should take an optional argument' do
      expect(TINAMI.respond_to?(:new, true)).to be_true
    end
  end

  describe '.adapter' do
    it 'should return the default adapter' do
      expect(TINAMI.adapter).to eql(TINAMI::Configuration::DEFAULT_ADAPTER)
    end
  end

  describe '.adapter=' do
    it 'should set the adapter' do
      TINAMI.adapter = :typhoeus
      expect(TINAMI.adapter).to eql(:typhoeus)
    end
  end

  describe '.endpoint' do
    it 'should return the default endpoint' do
      expect(TINAMI.endpoint).to eql(TINAMI::Configuration::DEFAULT_ENDPOINT)
    end
  end

  describe '.endpoint=' do
    it 'should set the endpoint' do
      TINAMI.endpoint = 'https://api.twitter.com/'
      expect(TINAMI.endpoint).to eql('https://api.twitter.com/')
    end
  end

  describe '.user_agent' do
    it 'should return the default user agent' do
      expect(TINAMI.user_agent).to eql(TINAMI::Configuration::DEFAULT_USER_AGENT)
    end
  end

  describe '.user_agent=' do
    it 'should set the user_agent' do
      TINAMI.endpoint = 'Custom User Agent'
      expect(TINAMI.endpoint).to eql('Custom User Agent')
    end
  end

  describe '.configure' do
    TINAMI::Configuration::VALID_OPTIONS_KEYS.each do |key|
      it "should set the #{key}" do
        TINAMI.configure do |config|
          config.send("#{key}=", key)
          expect(TINAMI.send(key)).to eql(key)
        end
      end
    end
  end
end
