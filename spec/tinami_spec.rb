require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TINAMI do
  describe :client do
    it { TINAMI.client.should be_a TINAMI::Client }
  end
end
