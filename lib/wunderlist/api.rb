require "wunderlist/folder"
require "wunderlist/list"
require "wunderlist/task"
require "wunderlist/user"
require "wunderlist/membership"
require "wunderlist/webhook"
require "wunderlist/version"
require 'faraday'
require 'json'

module Wunderlist
  class API

    attr_reader :access_token
    attr_reader :client_id

    attr_accessor :conn

    API_URL = "https://a.wunderlist.com"

    def initialize(options = {})
      @access_token = options[:access_token]
      @client_id = options[:client_id]
    end

    def conn
      @conn ||= Faraday::Connection.new(:url => API_URL) do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Adapter::NetHttp
      end
    end

    def new_task(list_name, attrs = {})
      attrs.stringify_keys
      list_name = [list_name]
      list_id = get_list_ids(list_name)[0]
      attrs['list_id'] = list_id
      task = Wunderlist::Task.new(attrs)
      task.api = self

      task

    end

    def new_folder(folder_name, list_names = [])
      list_ids = get_list_ids(list_names)
      attrs = {'title' => folder_name, 'list_ids' => list_ids}
      folder = Wunderlist::Folder.new(attrs)
      folder.api = self

      folder
    end

    def new_list(list_name)
      list = Wunderlist::List.new('title' => list_name)
      list.api = self
      list
    end

    def new_membership(membership_attrs = {})
      membership = Wunderlist::Membership.new(membership_attrs)
      membership.api = self
      membership
    end

    def members(list_id, status=["accepted"])
      res_memberships = self.request :get, "api/v1/memberships"
      user_ids = []
      res_memberships.each do |f|
        if status.include? f["state"]
          user_ids << f["user_id"]
        end
      end
      p user_ids
      users(user_ids) 
    end

    def accept_membership(membership_id, membership_attrs = {})
      self.request :patch, "/api/v1/memberships/#{membership_id}", membership_attrs
    end

    def folder(folder_name)
      folder_name = [folder_name]
      folder_ids = get_folder_ids(folder_name)
      get_folders_by_ids(folder_ids)[0]
      
    end

    def list(list_name)
      list_name = [list_name]
      list_ids = get_list_ids(list_name)
      get_lists_by_id(list_ids)[0]
    end

    def get_lists_by_ids(list_ids)
      lists = []
      list_ids.each do |list_id|
        res_list = self.request :get, "api/v1/lists/#{list_id}"
        list = Wunderlist::List.new(res_list)
        list.api = self

        lists << list
      end
      lists
    end

    def get_folders_by_ids(folder_ids)
      folders = []
      folder_ids.each do |folder_id|
        res_folder = self.request :get, "api/v1/folders/#{folder_id}"
        folder = Wunderlist::Folder.new(res_folder)
        folder.api = self

        folders << folder
      end
      folders
    end

    def folders
      res_folders = self.request :get, 'api/v1/folders'
      folders = []
      res_folders.each do |f|
        folder = Wunderlist::Folder.new(f)
        folder.api = self
        folders << folder
      end

      folders

    end

    def lists
      res_lists = self.request :get, 'api/v1/lists'
      lists = []
      res_lists.each do |l|
        list = Wunderlist::List.new(l)
        list.api = self
        lists << list
      end

      lists

    end

    def webhooks(list_name)
      list_id = get_list_ids([list_name]).first

      res_webhooks = self.request :get, 'api/v1/webhooks', { :list_id => list_id }
      res_webhooks.reduce([]) do |webhooks, webhook|
        webhook = Wunderlist::Webhook.new(webhook)
        webhook.api = self
        webhooks << webhook
      end
    end

    def tasks(list_names = [], completed = false)
      list_ids = get_list_ids(list_names)
      tasks = []
      list_ids.each do |list_id|
        res_tasks = self.request :get, 'api/v1/tasks', {:list_id => list_id, :completed => completed}
        if !res_tasks.empty?
          res_tasks.each do |t|
            task = Wunderlist::Task.new(t)
            task.api = self
            tasks << task
          end
        end
      end

      tasks

    end

    def all_users
      res_users = self.request :get, "api/v1/users"
      users = []
      res_users.each do |u|
        user = Wunderlist::User.new(u)
        user.api = self
        users << user
      end
      users
    end

    def users(user_ids)
      res_users = self.request :get, "api/v1/users"
      users = []
      res_users.each do |u|
        if user_ids.include? u["id"]
          user = Wunderlist::User.new(u)
          user.api = self
          users << user
        end
      end
      users
    end

    def user()
      res_user = self.request :get, 'api/v1/user'
      user = Wunderlist::User.new(res_user)
      user.api = self

      user
    end

    def new_task(list_name, attrs = {})
      attrs.stringify_keys
      list_name = [list_name]
      list_id = get_list_ids(list_name)[0]
      attrs['list_id'] = list_id
      task = Wunderlist::Task.new(attrs)
      task.api = self

      task

    end

    def new_sub_task(attrs = {})
      attrs.stringify_keys
      sub_task = Wunderlist::Subtask.new(attrs)
      sub_task.api = self

      sub_task

    end

    def new_webhook(list_name, attrs = {})
      attrs.stringify_keys
      list_name = [list_name]
      list_id = get_list_ids(list_name)[0]
      attrs['list_id'] = list_id
      task = Wunderlist::Webhook.new(attrs)
      task.api = self

      task

    end

    def request(method, url, options = {})
      case method
      when :get then self.get(url, options)
      when :post then self.post(url, options)
      when :put then self.put(url, options)
      when :patch then self.patch(url, options)
      when :delete then self.delete(url, options)
      end
    end

    def get(url, options = {})

      response = conn.get do |req|
        req.url url
        if options
          options.each do |k, v|
            req.params[k] = v
          end
        end
        req.headers = {
          'X-Access-Token' => self.access_token,
          'X-Client-ID' => self.client_id
        }
      end

      JSON.parse(response.body)

    end

    def post(url, options = {})

      response = conn.post do |req|
        req.url url
        req.body = options.to_json
        req.headers = {
          'X-Access-Token' => self.access_token,
          'X-Client-ID' => self.client_id,
          'Content-Type' => 'application/json',
          'Content-Encoding' => 'UTF-8'
        }
      end

      JSON.parse(response.body)
    end

    def put(url, options = {})

      response = conn.put do |req|
        req.url url
        req.body = options.to_json
        req.headers = {
          'X-Access-Token' => self.access_token,
          'X-Client-ID' => self.client_id,
          'Content-Type' => 'application/json',
          'Content-Encoding' => 'UTF-8'
        }
      end

      JSON.parse(response.body)
    end

    def patch(url, options = {})

      response = conn.patch do |req|
        req.url url
        req.body = options.to_json
        req.headers = {
          'X-Access-Token' => self.access_token,
          'X-Client-ID' => self.client_id,
          'Content-Type' => 'application/json',
          'Content-Encoding' => 'UTF-8'
        }
      end

      JSON.parse(response.body)
    end

    def delete(url, options = {})

      response = conn.delete do |req|
        req.url url
        req.params[:revision] = options[:revision]
        req.headers = {
          'X-Access-Token' => self.access_token,
          'X-Client-ID' => self.client_id,
          'Content-Encoding' => 'UTF-8'
        }
      end

      response.status

    end



    def get_list_ids(list_names = [])
      lists = self.lists
      if !list_names.empty?
        lists = lists.select{|elm| list_names.include?(elm.title)}
      end
      lists.map{|list| list.id}
    end

    def get_folder_ids(folder_names = [])
      folders = self.folders
      if !folder_names.empty?
        folders = folders.select{|elm| folder_names.include?(elm.title)}
      end
      folders.map{|folder| folder.id}
    end

  end
end
