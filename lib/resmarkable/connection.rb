# frozen_string_literal: true

# Copyright (C) 2026 Christopher Orion Phoenix <hello@chrisphoenix.dev>
# SPDX-License-Identifier: LGPL-3.0-or-later

require "faraday"

module Resmarkable
  # :nodoc:
  class Connection
    def initialize(host:, path:, token:)
      @uri = URI::HTTPS.build(host: host, path: path)
      @token = token
      @connection = create_connection
    end

    def get(path, query = nil, headers = nil)
      request(:get, path, query, headers)
    end

    def post(path, body = nil, headers = nil)
      request(:post, path, body, headers)
    end

    private

    def request(http_verb, path, payload = nil, headers = nil)
      @connection.public_send(http_verb, path) do |req|
        req.body = payload unless payload.nil?
        req.headers = headers unless headers.nil?
      end
    rescue Faraday::ConnectionFailed => e
      raise ConnectionFailed, e.message
    rescue Faraday::TimeoutError => e
      raise TimeoutError, e.message
    rescue Faraday::SSLError => e
      raise SSLError, e.message
    rescue Faraday::Error => e
      raise NetworkError, e.message
    end

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
