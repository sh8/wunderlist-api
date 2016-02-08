require 'spec_helper'

describe Wunderlist::API do
  it 'should have a version number' do
    expect(Wunderlist::VERSION).to_not be_nil
  end
end
