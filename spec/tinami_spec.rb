require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TINAMI do
  describe :client do
    it 'should be a TINAMI::Client' do
      TINAMI.client.should be_a TINAMI::Client
    end
  end

  describe :endpoint do
    it 'should == TINAMI::Configuration::DEFAULT_ENDPOINT' do
      TINAMI.endpoint.should == TINAMI::Configuration::DEFAULT_ENDPOINT
    end
  end
end
