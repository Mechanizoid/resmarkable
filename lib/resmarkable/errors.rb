# frozen_string_literal: true

# Copyright (C) 2026 Christopher Orion Phoenix <hello@chrisphoenix.dev>
# SPDX-License-Identifier: LGPL-3.0-or-later

module Resmarkable
  # Resmarkable error base class
  class Error < StandardError; end

  # Base class for HTTP errors (4xx and 5xx)
  class HttpError < Error
    attr_reader :status, :body, :headers, :original_exception

    def initialize(message = nil, exception: nil)
      @original_exception = exception
      @status = exception.response_status
      @body = exception.response_body
      @headers = exception.response_headers
      super(message || "HTTP Error: #{@status}")
    end
  end

  # HTTP Client Errors (4xx)
  class ClientError < HttpError; end

  # Server Errors (5xx)
  class ServerError < HttpError; end

  # Connection / Network / Timeout Errors
  class AdapterError < Error
    attr_reader :original_exception

    def initialize(message, exception = nil)
      @original_exception = exception
      super(message)
    end
  end

  class NetworkError < Error; end
  class TimeoutError < Error; end
end
