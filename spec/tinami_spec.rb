require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TINAMI do
  describe :client do
    it { TINAMI.client.should be_a TINAMI::Client }
  end

  describe :endpoint do
    it { TINAMI.endpoint.should == TINAMI::Configuration::DEFAULT_ENDPOINT }
  end
end
