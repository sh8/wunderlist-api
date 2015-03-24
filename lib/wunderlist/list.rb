require 'wunderlist/helper'

module Wunderlist
  class List

    include Wunderlist::Helper

    attr_accessor :id, :title, :api, :created_at, :revision

    def initialize(options = {})
      @api = options['api']
      @id = options['id']
      @title = options['title']
      @created_at = options['created_at']
      @revision = options['revision']
    end

    def tasks(completed = false)
      self.api.tasks([self.title])
    end

    private

    def set_attrs(res)
      self.api = res['api']
      self.id = res['id']
      self.task_id = res['task_id']
      self.content = res['content']
      self.created_at = res['created_at']
      self.updated_at = res['updated_at']
      self.revision = res['revision']
    end

  end
end
