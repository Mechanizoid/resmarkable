# frozen_string_literal: true

# Copyright (C) 2026, Christopher Orion Phoenix <hello@chrisphoenix.dev>
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY, without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/>

require 'optparse'

module Resmarkable
  # Initializes and encapsulates all runtime options
  class Options
    attr_accessor :user_name, :api_key

    attr_reader :curses_mode, :remaining_arguments

    def initialize(argv, env)
      @user_name = env['RESMARK_USER_NAME']
      @api_key = env['RESMARK_API_KEY']
      @curses_mode = false
      @remaining_arguments = nil

      parse_options(argv)
    end

    private

    # rubocop:disable Metrics/MethodLength
    def parse_options(argv)
      opt_parser = OptionParser.new do |parser|
        parser.require_exact = true

        parser.banner = 'Usage: resmarkable [options]'

        parser.on('-C', '--curses-mode', 'Enable curses mode') do
          @curses_mode = true
        end

        parser.on('-uNAME',
                  '--user-name=NAME',
                  'Your Resmark Systems username') do |username|
          @user_name = username
        end

        parser.on('-kKEY',
                  '--api-key=KEY',
                  'Your Resmark Systems api key') do |key|
          @api_key = key
        end
      end

      @remaining_arguments = opt_parser.parse!(argv)
    end
    # rubocop:enable Metrics/MethodLength
  end
end
