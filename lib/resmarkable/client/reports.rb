# frozen_string_literal: true

# Copyright (C) 2026 Christopher Orion Phoenix <hello@chrisphoenix.dev>
# SPDX-License-Identifier: LGPL-3.0-or-later

module Resmarkable
  class Client
    # :nodoc:
    # Mixin module for Reports endpoints
    module Reports
      # Accrual Date Details
      def accrual_date(from: nil, to: nil, **parameters)
        query = {
          from: from,
          to: to
        }.merge(parameters).compact

        @connection.get("report/accrual/transactionDate", query)
      end

      # Manifest Summary
      def manifest_summary(from = nil, to = nil, **parameters)
        named_parameters = {
          from: from,
          to: to,
          productId: nil,
          productName: nil
        }

        parameters = named_parameters.merge(parameters).compact

        @connection.post("report/manifest/summary", parameters)
      end
    end
  end
end
