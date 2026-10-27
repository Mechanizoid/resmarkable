# frozen_string_literal: true

# Copyright (C) 2026 Christopher Orion Phoenix <hello@chrisphoenix.dev>
# SPDX-License-Identifier: LGPL-3.0-or-later

require "uri"

require_relative "token"

module Resmarkable
  # Entry point for using API wrapper client
  class Client
    attr_accessor :user, :key, :sandbox, :host, :path

    def initialize(user:, key:, sandbox: true, token: nil)
      @user = user
      @key = key
      @sandbox = sandbox
      @host = sandbox ? SANDBOX_HOST : PRODUCTION_HOST
      @path = BASE_PATH
      @token = Token.new(
        user: user,
        key: key,
        host: host,
        path: path,
        saved_token: token
      )
    end

    def token
      value = @token.value
      {
        timestamp: @token.timestamp,
        value: value
      }
    end

    def say_hi
      uri = URI::HTTPS.build(host: @host, path: @path.to_s)

      puts "Hi, #{@user}! You are accessing the Resmark Systems API."
      puts "Base URL: #{uri}."
      puts "Your API key is #{@key}."
    end
  end
end
