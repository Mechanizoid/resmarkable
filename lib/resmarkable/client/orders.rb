# frozen_string_literal: true

# Copyright (C) 2026 Christopher Orion Phoenix <hello@chrisphoenix.dev>
# SPDX-License-Identifier: LGPL-3.0-or-later

module Resmarkable
  class Client
    # :nodoc:
    # Mixin module for Orders endpoints
    module Orders
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

      # Single Order
      def single_order(id)
        @connection.get("order/#{id}")
      end

      # Create New Order
      def create_order(id:,
                       order_id: nil,
                       billing: nil,
                       reference_id: nil,
                       **parameters
                      )
        payload = {
          id: id,
          orderId: order_id,
          billing: billing,
          referenceId: reference_id,
          disableNotification: nil,
          disablePendingOrderNotification: nil,
          disablePendingOrderNotificationResponse: nil,
          disableConfirmationEmail: nil
        }.merge(parameters).compact

        connection.post("order", payload)
      end

      # Cancel Order
      def cancel_order(id, apply_fee: nil)
        query = {
          applyCancellationFee: apply_fee
        }.compact

        @connection.delete("order/#{id}", query)
      end

      # Cancel Inventory Item
      def cancel_order_item(id, item_id, apply_fee: nil)
        query = {
          id: id,
          itemId: item_id,
          applyCancellationFee: apply_fee
        }.compact

        @connection.delete("order/#{id}/item/#{item_id}", query)
      end
    end
  end
end
