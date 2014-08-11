 # -*- encoding : utf-8 -*-
require "ant/version"
require "openssl"
require "net/http"
require "net/https"
require "uri"
require "json"
require "addressable/uri"

module Ant

  class API
    attr_accessor :api_key, :username, :nonce_v, :api_secret

    def initialize(username, api_key)
      self.username = username
      self.api_key = api_key
    end

    def api_call(method, param = {}, priv = false, action = '', is_json = true)
      url = "http://119.9.76.150/api/#{ method }/#{ action }"
      if priv
        self.nonce
        param.merge!(userId: self.username, :key => self.api_key, :signature => self.signature.to_s, :nonce => self.nonce_v)
      end
      answer = self.post(url, param)

      # unfortunately, the API does not always respond with JSON, so we must only
      # parse as JSON if is_json is true.
      if is_json
        JSON.parse(answer)
      else
        answer
      end
    end

    def account
      self.api_call('account.htm', {}, true)
    end

    def hashrate
      self.api_call('hashrate.htm', {}, true)
    end

    def nonce
      self.nonce_v = (Time.now.to_f * 1000000).to_i.to_s
    end

    def signature
      str = self.nonce_v + self.username + self.api_key
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha256'), self.api_secret ,str)
    end

    def post(url, param)
      uri = URI.parse(url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      params = Addressable::URI.new
      params.query_values = param
      https.post(uri.path, params.query).body
    end
  end
end
