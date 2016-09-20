require 'wunderlist/helper'

module Wunderlist
  class Folder

    include Wunderlist::Helper

    attr_accessor :id, :title, :api, :created_at, :revision, :list_ids

    def initialize(attrs = {})
      @api = attrs['api']
      @id = attrs['id']
      @title = attrs['title']
      @created_at = attrs['created_at']
      @revision = attrs['revision']
      @list_ids = attrs['list_ids']
    end

    def lists
      self.api.get_lists_by_ids(self.list_ids)
    end

    def webhooks
      self.api.webhooks(self.title)
    end

    private

    def set_attrs(attrs = {})
      self.api = attrs['api']
      self.id = attrs['id']
      self.title= attrs['title']
      self.created_at = attrs['created_at']
      self.revision = attrs['revision']
      self.list_ids = attrs['list_ids']
    end

  end
end
