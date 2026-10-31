# frozen_string_literal: true

# Copyright (C) 2026 Christopher Orion Phoenix <hello@chrisphoenix.dev>
# SPDX-License-Identifier: LGPL-3.0-or-later

module Resmarkable
  class Client
    # :nodoc:
    # Mixin module for Carts endpoints
    module Carts
      # Create a new empty cart
      def create_cart(supplier_id = nil)
        query = {
          supplierId: supplier_id
        }.compact

        @connection.post("cart", query)
      end

      # Retrieve paginated list of all carts
      def retrieve_all_carts
        @connection.get("cart")
      end

      # Retrieve a single cart
      def retrieve_cart(id)
        @connection.get("cart/#{id}")
      end
    end
  end
end
