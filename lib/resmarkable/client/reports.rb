# frozen_string_literal: true

# Copyright (C) 2026 Christopher Orion Phoenix <hello@chrisphoenix.dev>
# SPDX-License-Identifier: LGPL-3.0-or-later

module Resmarkable
  class Client
    # :nodoc:
    # Mixin module for reports endpoints
    module Reports
      def order (
            limit: nil,
            page: nil,
            from_created_date: nil,
            to_created_date: nil
          )
        query = {}

        query[:limit] = limit unless limit.nil?
        query[:page] = page unless page.nil?
        query[:fromCreatedDate] = from_created_date unless from_created_date.nil?
        query[:toCreatedDate] = to_created_date unless to_created_date.nil?

        @connection.get("order", query)
      end

      def single_order(id)
        @connection.get("order/#{id}")
      end
    end
  end
end
