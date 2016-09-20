require 'wunderlist/helper'

module Wunderlist
  class Membership

    include Wunderlist::Helper

    attr_accessor :id, :list_id, :user_id, :state, :muted, :api, :revision, :email

    def initialize(attrs = {})
      @api = attrs['api']
      @id = attrs['id']
      @list_id = attrs['list_id']
      @user_id = attrs['user_id']
      @state = attrs['state']
      @muted = attrs['muted']
      @revision = attrs['revision']
      @email = attrs['email']
    end

    def webhooks
      self.api.webhooks(self.title)
    end

    def accept
      self.state = "accepted"
      accept_membership_attrs = {"state" => self.state, "revision" => self.revision}
      self.api.accept_membership(self.id, accept_membership_attrs)
    end

    private

    def set_attrs(attrs = {})
      self.id = attrs['id']
      self.list_id = attrs['list_id']
      self.user_id = attrs['user_id']
      self.state = attrs['state']
      self.muted = attrs['muted']
      self.revision = attrs['revision']
    end

  end
end
