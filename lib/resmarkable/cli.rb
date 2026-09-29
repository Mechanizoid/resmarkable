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

require_relative './options'

module Resmarkable
  # Initializes and manages the CLI interface that the user interacts with
  class CLI
    def self.start(argv, env)
      new(argv, env).run
    end

    def initialize(argv, env)
      @options = Resmarkable::Options.new(argv, env)
    end

    def run
      puts 'Resmarkable says hi!'
      puts "user name: #{@options.user_name}, api_key: #{@options.api_key}"
      puts @options.remaining_arguments
    end
  end
end
