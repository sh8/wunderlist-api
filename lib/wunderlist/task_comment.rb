require 'wunderlist/helper'

module Wunderlist
  class TaskComment

    include Wunderlist::Helper

    attr_accessor :text, :type, :id, :api, :task_id, :revision, :created_at

    def initialize(options = {})
      @api = options['api']
      @id = options['id']
      @task_id = options['task_id']
      @revision = options['revision']
      @text = options['text']
      @type = options['type']
      @created_at = options['created_at']
    end

    private

    def set_attrs(res)
      self.api = res['api']
      self.id = res['id']
      self.task_id = res['task_id']
      self.revision = res['revision']
      self.text = res['text']
      self.type = res['type']
      self.created_at = res['created_at']
    end

  end
end
