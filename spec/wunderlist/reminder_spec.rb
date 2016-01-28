require 'spec_helper'

describe Wunderlist::Reminder do
  let(:reminder) { described_class.new }

  describe "a reminder" do
    it "has a model name" do
      expect(reminder.model_name).to eq 'reminder'
    end
  end
end
