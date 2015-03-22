require 'wunderlist/helper'

module Wunderlist
  class TaskComment

    include Wunderlist::Helper

    attr_accessor :text, :type
    attr_reader   :id, :task_id, :revision, :created_at


    def initialize(options = {})
      @api = options['api']
      @id = options['id']
      @task_id = options['task_id']
      @revision = options['revision']
      @text = options['text']
      @type = options['type']
      @created_at = options['created_at']
    end

    def save
    end
  end
end
