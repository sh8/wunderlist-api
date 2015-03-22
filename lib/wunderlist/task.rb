require 'wunderlist/helper'
require 'wunderlist/note'
require 'wunderlist/task_comment'

module Wunderlist
  class Task

    include Wunderlist::Helper

    attr_accessor :api, :title, :assignee_id, :completed, :recurrence_type, :recurrence_count, :due_date, :starred
    attr_reader :id, :list_id

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
    
    def save
      self.api.request :post, 'api/v1/tasks', self.to_hash
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

    def notes
      res = self.api.request :get, 'api/v1/notes', {:task_id => self.id}
      notes = []

      res.each do |note|
        note = Wunderlist::Note.new(note)
        note.api = self.api
        notes << note
      end

      if notes.empty?
        note = Wunderlist::Note.new('task_id' => self.id)
        note.api = self.api
        notes << note
      end

      notes

    end

  end
end
