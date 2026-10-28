# frozen_string_literal: true

# Copyright (C) 2026 Christopher Orion Phoenix <hello@chrisphoenix.dev>
# SPDX-License-Identifier: LGPL-3.0-or-later

module Resmarkable
  class Client
    # :nodoc:
    # Mixin module for reports endpoints
    module Reports
      # Order API endpoint (returns a paginated list of orders)
      # rubocop:disable-next Metrics/MethodLength
      def order(**parameters)
        named_parameters = {
          limit: nil,
          page: nil,
          ids: nil,
          confirmationIds: nil,
          fromCreatedDate: nil,
          toCreatedDate: nil,
          fromModifiedDate: nil,
          toModifiedDate: nil,
          referenceId: nil,
          sortOrder: nil
        }

        query = named_parameters.merge(parameters).compact

        @connection.get("order", query)
      end

      def single_order(id)
        @connection.get("order/#{id}")
      end
    end
  end
end
