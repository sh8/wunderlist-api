require 'spec_helper'

describe Wunderlist::TaskComment do
  let(:task_comment) { described_class.new }

  describe "a task_comment" do
    it "has a model name" do
      expect(task_comment.model_name).to eq 'task_comment'
    end
  end
end
