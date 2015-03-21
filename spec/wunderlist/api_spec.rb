require 'spec_helper'

describe Wunderlist::Api do
  it 'should have a version number' do
    Wunderlist::Api::VERSION.should_not be_nil
  end

  it 'should do something useful' do
    false.should eq(true)
  end
end
