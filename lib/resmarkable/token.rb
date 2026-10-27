# frozen_string_literal: true

# Copyright (C) 2026 Christopher Orion Phoenix <hello@chrisphoenix.dev>
# SPDX-License-Identifier: LGPL-3.0-or-later

require "faraday"
require "pathname"
require "uri"

module Resmarkable
  # :nodoc:
  # Internal class for fetching and storing API tokens
  class Token
    attr_reader :timestamp

    TOKEN_LIFETIME = 86_400 # Resmark Systems API tokens expire after 24 hours
    REFRESH_BUFFER = 600    # Fetch a new token 10 minutes before it expires

    def initialize(user:, key:, host:, path:, saved_token: nil)
      @request_body = {
        username: user,
        apikey: key
      }

      @headers = { "Content-Type" => "application/json" }

      auth_path = Pathname.new(path).join("authenticate")
      @uri = URI::HTTPS.build(host: host, path: auth_path.to_s)

      if saved_token.nil?
        @value = nil
        @timestamp = nil
      else
        @value = saved_token[:value]
        @timestamp = saved_token[:timestamp]
      end
    end

    def value
      fetch if should_fetch?
      @value
    end

    def to_s
      value
    end

    private

    def fetch
      response = Faraday.post(@uri, @request_body.to_json, @headers)

      @timestamp = Time.now
      @value = response.body
    end

    def should_fetch?
      @value.nil? || expired?
    end

    def expired?
      Time.now - @timestamp > TOKEN_LIFETIME - REFRESH_BUFFER
    end
  end
end
