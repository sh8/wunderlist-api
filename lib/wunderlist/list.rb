require 'wunderlist/helper'

module Wunderlist
  class List

    include Wunderlist::Helper

    attr_accessor :id, :title, :api, :created_at, :revision

    def initialize(attrs = {})
      @api = attrs['api']
      @id = attrs['id']
      @title = attrs['title']
      @created_at = attrs['created_at']
      @revision = attrs['revision']
    end

    def new_task(attrs = {})
      self.api.new_task(self.title, attrs)
    end

    def tasks(completed = false)
      self.api.tasks([self.title], completed)
    end

    private

    def set_attrs(attrs = {})
      self.api = attrs['api']
      self.id = attrs['id']
      self.title= attrs['content']
      self.created_at = attrs['created_at']
      self.revision = attrs['revision']
    end

  end
end
