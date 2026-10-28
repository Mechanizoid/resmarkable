# frozen_string_literal: true

# Copyright (C) 2026 Christopher Orion Phoenix <hello@chrisphoenix.dev>
# SPDX-License-Identifier: LGPL-3.0-or-later

require "uri"

require_relative "connection"
require_relative "token"
require_relative "client/reports"

module Resmarkable
  # Entry point for using API wrapper client
  class Client
    include Reports

    attr_accessor :user, :key, :sandbox, :host, :path

    def initialize(user:, key:, sandbox: true, token: nil)
      @user = user
      @key = key
      @host = sandbox ? SANDBOX_HOST : PRODUCTION_HOST
      @path = BASE_PATH
      @token = Token.new(user: user, key: key, host: host,
                         path: path, saved_token: token)
      @uri = URI::HTTPS.build(host: @host, path: @path.to_s)
      @connection = Connection.new(host: @host, path: @path, token: @token)
    end

    # Return API token value and timestamp to user (facilitating storage
    # and reuse of tokens, as a token is valid for 24 hours)
    def token
      value = @token.value
      {
        timestamp: @token.timestamp,
        value: value
      }
    end

    def say_hi
      puts "Hi, #{@user}! You are accessing the Resmark Systems API."
      puts "Base URL: #{@uri}."
      puts "Your API key is #{@key}."
    end

    private_constant :Reports
  end
end
