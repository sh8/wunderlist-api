require 'spec_helper'

describe Wunderlist::Task do
  let(:api) { Wunderlist::API.new }
  let(:task) { described_class.new }

  describe "a task" do
    it 'has a hash representation' do
      expect(task.to_hash.keys).to include(*%w(
        id
        list_id
        title
        revision
        assignee_id
        completed
        completed_at
        completed_by_id
        recurrence_type
        recurrence_count
        due_date
        starred
        )
      )
    end

    it "has a model name" do
      expect(task.model_name).to eq 'task'
    end
  end
end
