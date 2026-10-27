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
      @host = sandbox ? SANDBOX_HOST : PRODUCTION_HOST
      @path = BASE_PATH
      @token = Token.new(user: user, key: key, host: host,
                         path: path, saved_token: token)
      @uri = URI::HTTPS.build(host: @host, path: @path.to_s)
      @connection = create_connection
    end

    # Test method
    def get_single_order(id)
      @connection.get("order/#{id}")
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

    private

    def create_connection
      Faraday.new(url: @uri) do |builder|
        # Call Token.value on each request to get a valid API token
        builder.request :authorization, 'Bearer', -> { @token.value }

        # Set the Content-Type header to application/json on each request
        builder.request :json

        # Parse JSON response bodies
        builder.response :json
      end
    end
  end
end
