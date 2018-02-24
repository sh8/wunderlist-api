require "wunderlist/list"
require "wunderlist/task"
require "wunderlist/user"
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

    def new_list(list_name)
      list = Wunderlist::List.new('title' => list_name)
      list.api = self
      list
    end

    def list(list_name_or_id)
      list_id = get_list_ids(list_name_or_id).first

      res_list = self.request :get, "api/v1/lists/#{list_id}"
      list = Wunderlist::List.new(res_list)
      list.api = self

      list

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

    def webhooks(list_name_or_id)
      list_id = get_list_ids(list_name_or_id).first

      res_webhooks = self.request :get, 'api/v1/webhooks', { :list_id => list_id }
      res_webhooks.reduce([]) do |webhooks, webhook|
        webhook = Wunderlist::Webhook.new(webhook)
        webhook.api = self
        webhooks << webhook
      end
    end

    def tasks(list_names_or_ids = [], completed = false)
      list_ids = get_list_ids(list_names_or_ids)
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

    def new_webhook(list_name_or_id, attrs = {})
      list_id = get_list_ids(list_name_or_id).first
      attrs.stringify_keys
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
      if list_names.is_a? Array and list_names.all? {|i| i.is_a?(Integer) }
        return list_names
      end
      return [list_names] if list_names.is_a? Integer
      list_names = [list_names] if list_names.is_a? String

      lists = self.lists
      if !list_names.empty?
        lists = lists.select{|elm| list_names.include?(elm.title)}
      end
      lists.map{|list| list.id}
    end

  end
end
