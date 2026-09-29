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

module Resmarkable
  # Initializes and manages the CLI interface that the user interacts with
  class CLI
    def self.start(argv)
      new(argv).run
    end

    def initialize(argv)
      @argv = argv
      # During development, program will read API credentials from environment
      # variables
      @resmark_user_name = ENV['RESMARK_USER_NAME']
      @resmark_api_key = ENV['RESMARK_API_KEY']
    end

    def run
      puts 'Resmarkable says hi!'
      puts "user name: #{@resmark_user_name}, api_key: #{@resmark_api_key}"
      puts @argv
    end
  end
end
