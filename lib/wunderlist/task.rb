require 'wunderlist/note'
require 'wunderlist/task_comment'
require 'wunderlist/helper'

module Wunderlist
  class Task

    include Wunderlist::Helper

    attr_accessor :api, :title, :assignee_id, :completed, :revision, :recurrence_type, :recurrence_count, :due_date, :starred, :id, :list_id, :created_at

    def initialize(options = {})
      @api = options['api']
      @id = options['id']
      @list_id = options['list_id']
      @title = options['title']
      @assignee_id = options['assignee_id']
      @completed = options['completed']
      @recurrence_type = options['recurrence_type']
      @recurrence_count = options['recurrence_count']
      @due_date = options['due_date']
      @starred = options['starred']
    end

    def task_comments
      res = self.api.request :get, 'api/v1/task_comments', {:task_id => self.id}
      task_comments = []

      res.each do |t_c|
        task_comment = Wunderlist::TaskComment.new(t_c)
        task_comment.api = self.api
        task_comments << task_comment
      end

      task_comments

    end

    def note
      res = self.api.request :get, 'api/v1/notes', {:task_id => self.id}
      if !res[0].nil?
        note = Wunderlist::Note.new(res[0])
      else
        note = Wunderlist::Note.new('task_id' => self.id)
      end

      note.api = self.api
      note.task_id = self.id

      note

    end

    private

    def set_attrs(res)
      self.id = res['id']
      self.title = res['title']
      self.created_at = res['created_at']
      self.completed = res['completed']
      self.list_id = res['list_id']
      self.starred = res['starred']
      self.revision = res['revision']
    end

  end
end
