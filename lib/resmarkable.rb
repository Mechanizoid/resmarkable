# frozen_string_literal: true

# Copyright (C) 2026 Christopher Orion Phoenix <hello@chrisphoenix.dev>
# SPDX-License-Identifier: LGPL-3.0-or-later

require_relative "resmarkable/version"
require_relative "resmarkable/client"

module Resmarkable
  class Error < StandardError; end
  # Default URL hosts
  PRODUCTION_HOST = "app.resmarksystems.com"
  SANDBOX_HOST = "sandbox.resmarksystems.com"

  # Default API base path
  BASE_PATH = "/public/api"

end
