require 'wunderlist/helper'

module Wunderlist
  class Subtask

    include Wunderlist::Helper

    attr_accessor :id, :api, :task_id, :created_at, :created_by_id, :revision, :title

    def initialize(attrs = {})
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
      self.id = attrs['id']
      self.api = attrs['api']
      self.task_id = attrs['task_id']
      self.created_at = attrs['created_at']
      self.created_by_id = attrs['created_by_id']
      self.revision = attrs['revision']
      self.title = attrs['title']
    end

  end
end
