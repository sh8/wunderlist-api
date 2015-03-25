require 'wunderlist/helper'

module Wunderlist
  class Subtask

    include Wunderlist::Helper

    attr_accessor :id, :api, :task_id, :created_at, :created_by_id, :revision, :title

    def intialize(attrs = {})
      @id = attrs['id']
      @api = attrs['api']
      @task_id = attrs['task_id']
      @created_at = attrs['created_at']
      @created_by_id = attrs['created_by_id']
      @revision = attrs['revision']
      @title = attrs['title']
    end

    private

    def set_attrs(attrs = {})
      @id = attrs['id']
      @api = attrs['api']
      @task_id = attrs['task_id']
      @created_at = attrs['created_at']
      @created_by_id = attrs['created_by_id']
      @revision = attrs['revision']
      @title = attrs['title']
    end

  end
end
