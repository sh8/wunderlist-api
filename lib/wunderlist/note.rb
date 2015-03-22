require 'wunderlist/helper'
require 'wunderlist/api'

module Wunderlist
  class Note

    include Wunderlist::Helper

    attr_accessor :content, :api
    attr_reader :id, :task_id, :created_at, :updated_at, :revision

    def initialize(options = {})
      @api = options['api']
      @id = options['id']
      @task_id = options['task_id']
      @content = options['content']
      @created_at = options['created_at']
      @updated_at = options['updated_at']
      @revision = options['revision']
    end

    def update
      if self.id.nil?
        self.create
      else
        self.api.request :put, "api/v1/notes/#{self.id}", self.to_hash
      end
    end

    def create
      puts self.api.request :post, "api/v1/notes", self.to_hash
    end

  end
end
