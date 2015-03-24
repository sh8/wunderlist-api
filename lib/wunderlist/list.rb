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

    def new_task(list_name, attrs = {})
      self.api.new_task(list_name, attrs)
    end

    def tasks(completed = false)
      self.api.tasks([self.title])
    end

    private

    def set_attrs(res)
      self.api = res['api']
      self.id = res['id']
      self.title= res['content']
      self.created_at = res['created_at']
      self.revision = res['revision']
    end

  end
end
