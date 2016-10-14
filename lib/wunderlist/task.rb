require 'wunderlist/note'
require 'wunderlist/task_comment'
require 'wunderlist/subtask'
require 'wunderlist/reminder'
require 'wunderlist/helper'

module Wunderlist
  class Task

    include Wunderlist::Helper

    attr_accessor :api, :title, :assignee_id, :completed, :revision, :recurrence_type, :recurrence_count, :due_date, :starred, :id, :list_id, :created_at, :completed_at, :completed_by_id

    def initialize(attrs = {})
      @api = attrs['api']
      @id = attrs['id']
      @list_id = attrs['list_id']
      @title = attrs['title']
      @revision = attrs['revision']
      @assignee_id = attrs['assignee_id']
      @completed = attrs['completed']
      @completed_at = attrs['completed_at']
      @completed_by_id = attrs['completed_by_id']
      @recurrence_type = attrs['recurrence_type']
      @recurrence_count = attrs['recurrence_count']
      @due_date = attrs['due_date']
      @starred = attrs['starred']
    end

    def comments
      res = self.api.request :get, 'api/v1/task_comments', {:task_id => self.id}
      task_comments = []

      res.each do |t_c|
        task_comment = Wunderlist::TaskComment.new(t_c)
        task_comment.api = self.api
        task_comments << task_comment
      end
      task_comments
    end

    def new_comment(attrs = {})
      attrs.stringify_keys
      t_c = Wunderlist::TaskComment.new(attrs)
      t_c.api = self.api
      t_c.task_id = self.id
      t_c
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

    # def new_note(attrs = {})
    #   attrs.stringify_keys
    #   note = Wunderlist::Note.new(attrs)
    #   note.api = self.api
    #   note.task_id = self.id
    #   note
    # end

    def files
      # TODO
    end

    def new_file(attrs = {})
      # TODO
    end

    def reminders
      res = self.api.request :get, 'api/v1/reminders', {:task_id => self.id}
      if !res[0].nil?
        reminder = Wunderlist::Reminder.new(res[0])
      else
        reminder = Wunderlist::Reminder.new('task_id' => self.id)
      end

      reminder.api = self.api
      reminder.task_id = self.id
      reminder
    end

    def new_reminder
      # Need to be tested 
      attrs.stringify_keys
      rem = Wunderlist::Reminder.new(attrs)
      rem.api = self.api
      rem.task_id = self.id
      rem
    end

    def subtasks
      res = self.api.request :get, 'api/v1/subtasks', {:task_id => self.id}
      subtasks = []
      res.each do |r|
        subtask = Wunderlist::Subtask.new(r)
        subtask.api = self
        subtasks << subtask
      end
      #This will return tasks in backwards order, so reverse them
      subtasks.reverse
    end

    def new_subtask(attrs = {})
      attrs.stringify_keys
      s_t = Wunderlist::Subtask.new(attrs)
      s_t.api = self.api
      s_t.task_id = self.id
      s_t
    end

    private

    def set_attrs(attrs = {})
      self.id = attrs['id']
      self.title = attrs['title']
      self.created_at = attrs['created_at']
      self.completed = attrs['completed']
      self.list_id = attrs['list_id']
      self.starred = attrs['starred']
      self.revision = attrs['revision']
    end

  end
end
