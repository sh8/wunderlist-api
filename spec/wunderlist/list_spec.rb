require 'spec_helper'

describe Wunderlist::List do
  let(:list) { described_class.new }

  describe "a list" do
    it "has a model name" do
      expect(list.model_name).to eq 'list'
    end
  end
end
