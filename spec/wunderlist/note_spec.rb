require 'spec_helper'

describe Wunderlist::Note do
  let(:note) { described_class.new }

  describe "a note" do
    it "has a model name" do
      expect(note.model_name).to eq 'note'
    end
  end
end
