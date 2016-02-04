module Wunderlist
  class Webhook

    include Wunderlist::Helper

    attr_accessor :api, :id, :list_id, :created_by_id, :processor_type, :url, :configuration, :created_at

    def initialize(attrs = {})
      @list_id = attrs['list_id']
      @id = attrs['id']
      @created_by_id = attrs['created_by_id']
      @processor_type = attrs['processor_type']
      @url = attrs['url']
      @created_at = attrs['created_at']
      @configuration = attrs['configuration']
    end

    def destroy
      # Seems no revision id is needed, contrary to documentation
      self.api.request :delete, resource_path
      self.id = nil

      self
    end
  end
end