require 'wunderlist/helper'

module Wunderlist
  class Note

    include Wunderlist::Helper

    attr_accessor :id, :content, :api, :task_id, :created_at, :updated_at, :revision

    def initialize(attrs = {})
      @api = attrs['api']
      @id = attrs['id']
      @task_id = attrs['task_id']
      @content = attrs['content']
      @created_at = attrs['created_at']
      @updated_at = attrs['updated_at']
      @revision = attrs['revision']
      p "initialize !!"
    end

    private

    def set_attrs(attrs = {})
      self.api = attrs['api']
      self.id = attrs['id']
      self.task_id = attrs['task_id']
      self.content = attrs['content']
      self.created_at = attrs['created_at']
      self.updated_at = attrs['updated_at']
      self.revision = attrs['revision']
    end

  end
end
