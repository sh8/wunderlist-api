require "wunderlist/version"
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

    def tasks(list_names = [])
      list_ids = get_list_ids(list_names)
      list_ids.each do |list_id|
        self.request :get, 'api/v1/tasks', {:list_id => list_id}
      end
    end

    def request(method, url, options = {})
      case method
      when :get then self.get(url, options)
      when :post then self.post(url, options)
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

    def get_list_ids(list_names = [])
      lists = self.lists
      if !list_names.empty?
        lists = lists.select{|elm| list_names.include?(elm["title"])}
      end
      lists.map{|list| list['id']}
    end

  end
end
