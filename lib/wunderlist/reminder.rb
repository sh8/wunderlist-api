require 'wunderlist/helper'

module Wunderlist
  class Reminder

    include Wunderlist::Helper

    attr_accessor :id, :api, :task_id, :created_at, :updated_at, :date, :revision

    def initialize(attrs = {})
      @id = attrs['id']
      @api = attrs['api']
      @task_id = attrs['task_id']
      @created_at = attrs['created_at']
      @updated_at = attrs['updated_at']
      @date = attrs['date']
      @revision = attrs['revision']
    end

    def date=(value)
      @date = Time.parse(value).getlocal.iso8601
    end

    private

    def set_attrs(attrs = {})
      self.id = attrs['id']
      self.api = attrs['api']
      self.task_id = attrs['task_id']
      self.created_at = attrs['created_at']
      self.updated_at = attrs['updated_at']
      self.date = attrs['date']
      self.revision = attrs['revision']
    end

  end
end
