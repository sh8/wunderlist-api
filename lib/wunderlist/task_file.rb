require 'wunderlist/helper'

module Wunderlist
  class TaskFile

    include Wunderlist::Helper

    attr_accessor :file_name, :file_size, :content_type, :url, :type, :id, :api, :task_id, :revision, :created_at

    def initialize(attrs = {})
      @api = attrs['api']
      @id = attrs['id']
      @task_id = attrs['task_id']
      @revision = attrs['revision']
      @type = attrs['type']
      @content_type = attrs['content_type']
      @file_size = attrs['file_size']
      @file_name = attrs['file_name']
      @url = attrs['url']
      @created_at = attrs['created_at']
    end

    private

    def set_attrs(attrs = {})
      self.api = attrs['api']
      self.id = attrs['id']
      self.task_id = attrs['task_id']
      self.revision = attrs['revision']
      self.type = attrs['type']
      self.content_type = attrs['content_type']
      self.file_size = attrs['file_size']
      self.url = attrs['url']
      self.created_at = attrs['created_at']
    end

  end
end
