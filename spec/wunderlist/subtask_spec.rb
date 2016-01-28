require 'spec_helper'

describe Wunderlist::Subtask do
  let(:subtask) { described_class.new }

  describe "a subtask" do
    it "has a model name" do
      expect(subtask.model_name).to eq 'subtask'
    end
  end
end
