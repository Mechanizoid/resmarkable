# frozen_string_literal: true

# Copyright (C) 2026 Christopher Orion Phoenix <hello@chrisphoenix.dev>
# SPDX-License-Identifier: LGPL-3.0-or-later

module Resmarkable
  # Resmarkable error base class
  class Error < StandardError; end

  # HTTP Client Errors (4xx)
  class ClientError < Error
    attr_reader :response, :status

    def initialize(response)
      @response = response
      @status = response&.fetch(:status, nil)
      @body = response&.fetch(:body, nil)
      super("HTTP #{@status}: #{@body}")
    end
  end

  # Server Errors (5xx)
  class ServerError < Error
    attr_reader :response, :status_code

    def initialize(response)
      @response = response
      @status = response&.fetch(:status, nil)
      @body = response&.fetch(:body, nil)
      super("Server error #{@status}: #{@body}")
    end
  end

  # Connection / Network / Timeout Errors
  class NetworkError < Error; end

  class ConnectionFailed < NetworkError; end
  class TimeoutError < NetworkError; end
  class SSLError < NetworkError; end
end
