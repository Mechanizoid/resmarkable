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

      # Transaction Date Details
      def transaction_date(from: nil, to: nil, **parameters)
        query = {
          from: from,
          to: to,
          orderIds: nil,
          confirmationIds: nil,
          productNumbers: nil,
          fromProductStartDate: nil,
          toProductStartDate: nil
        }.merge(parameters).compact

        @connection.get("report/order/transactionDate", query)
      end

      # Mailing List by Order
      def mailing_list_by_order(**parameters)
        query = {
          from: nil,
          to: nil,
          productId: nil,
          class: nil,
          subscribed: nil,
          customerType: nil,
          dateMode: nil,
          skip: nil
        }.merge(parameters).compact

        @connection.get("report/mailingListbyOrder/productStartDate", query)
      end

      # Manifest Summary
      def manifest_summary(from: nil, to: nil, product_id: nil,
                           product_name: nil, **parameters)
        payload = {
          from: from,
          to: to,
          productId: product_id,
          productName: product_name
        }.merge(parameters).compact

        @connection.post("report/manifest/summary", payload)
      end
    end
  end
end
