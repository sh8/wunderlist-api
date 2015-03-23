require "wunderlist/version"
require "wunderlist/task"
require 'wunderlist/helper'
require 'faraday'
require 'json'

module Wunderlist
  class API

    attr_reader :access_token
    attr_reader :client_id

    API_URL = "https://a.wunderlist.com"

    def initialize(options = {})
      @conn = Faraday::Connection.new(:url => API_URL) do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Response::Logger
        builder.use Faraday::Adapter::NetHttp
      end
      @access_token = options[:access_token]
      @client_id = options[:client_id]
    end

    def lists
      self.request :get, 'api/v1/lists'
    end

    def tasks(list_names = [], completed = false)
      list_ids = get_list_ids(list_names)
      tasks = []
      list_ids.each do |list_id|
        list_tasks = self.request :get, 'api/v1/tasks', {:list_id => list_id, :completed => completed}
        if !list_tasks.empty?
          list_tasks.each do |t|
            task = Wunderlist::Task.new(t)
            task.api = self
            tasks << task
          end
        end
      end

      tasks

    end

    def new_task(list_name, attrs = {})
      attrs.stringify_keys
      list_name = [list_name]
      list_id = get_list_ids(list_name)[0]
      attrs['list_id'] = list_id
      attrs['api'] = self
      @task = Wunderlist::Task.new(attrs)
    end

    def request(method, url, options = {})
      case method
      when :get then self.get(url, options)
      when :post then self.post(url, options)
      when :put then self.put(url, options)
      end
    end

    def get(url, options = {})

      response = @conn.get do |req|
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

      response = @conn.post do |req|
        req.url url
        req.body = options.to_json
        req.headers = {
          'X-Access-Token' => self.access_token,
          'X-Client-ID' => self.client_id,
          'Content-Type' => 'text/json',
          'Content-Encoding' => 'UTF-8'
        }
      end

      JSON.parse(response.body)
    end

    def put(url, options = {})

      response = @conn.put do |req|
        req.url url
        req.body = options.to_json
        req.headers = {
          'X-Access-Token' => self.access_token,
          'X-Client-ID' => self.client_id,
          'Content-Type' => 'text/json',
          'Content-Encoding' => 'UTF-8'
        }
      end

      JSON.parse(response.body)
    end


    def get_list_ids(list_names = [])
      lists = self.lists
      if !list_names.empty?
        lists = lists.select{|elm| list_names.include?(elm["title"])}
      end
      lists.map{|list| list['id']}
    end

  end
end
