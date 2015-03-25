require 'wunderlist/helper'

module Wunderlist
  class TaskComment

    include Wunderlist::Helper

    attr_accessor :text, :type, :id, :api, :task_id, :revision, :created_at

    def initialize(attrs = {})
      @api = attrs['api']
      @id = attrs['id']
      @task_id = attrs['task_id']
      @revision = attrs['revision']
      @text = attrs['text']
      @type = attrs['type']
      @created_at = attrs['created_at']
    end

    private

    def set_attrs(attrs = {})
      self.api = attrs['api']
      self.id = attrs['id']
      self.task_id = attrs['task_id']
      self.revision = attrs['revision']
      self.text = attrs['text']
      self.type = attrs['type']
      self.created_at = attrs['created_at']
    end

  end
end
