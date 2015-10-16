

module Wunderlist
  class User

    include Wunderlist::Helper

    attr_accessor :api, :id, :name, :email, :created_at

    def initialize(attrs = {})
      @id = attrs['id']
      @name = attrs['name']
      @email = attrs['email']
      @created_at = attrs['created_at']
    end

  end
end
