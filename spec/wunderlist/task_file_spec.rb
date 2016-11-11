require 'spec_helper'

describe Wunderlist::TaskFile do
  let(:task_file) { described_class.new }

  describe "a task_file" do
    it "has a model name" do
      expect(task_file.model_name).to eq 'task_file'
    end
  end
end
