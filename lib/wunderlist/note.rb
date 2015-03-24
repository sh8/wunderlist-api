require 'wunderlist/helper'

module Wunderlist
  class Note

    include Wunderlist::Helper

    attr_accessor :id, :content, :api, :task_id, :created_at, :updated_at, :revision

    def initialize(options = {})
      @api = options['api']
      @id = options['id']
      @task_id = options['task_id']
      @content = options['content']
      @created_at = options['created_at']
      @updated_at = options['updated_at']
      @revision = options['revision']
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
