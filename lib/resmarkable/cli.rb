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

require 'colorize'

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
      puts "Welcome to Resmarkable #{Resmarkable::VERSION}!\n".colorize(:red)

      puts 'OPTIONS SET:'.colorize(:green)
      puts "user name: #{@options.user_name}, api_key: #{@options.api_key}"

      if @options.curses_mode
        puts 'Curses mode enabled, but feature is not yet implemented'
      else
        puts 'Curses mode set to false'
      end

      print "Remaining arguments: #{@options.remaining_arguments}\n\n"

      start_repl
    end

    private

    def start_repl
      loop do
        input = prompt_user

        print "\n" if input.nil?

        break if input.nil? || input == 'Q'

        next if input.empty?

        puts "You chose to #{choice(input)}."
      end
    end

    def prompt_user
      puts 'Commands: M(anifest), V(iew order), S(earch), H(elp), Q(uit)'
      print 'Enter> '.colorize(:green)

      gets&.chomp&.upcase
    end

    def choice(input)
      operation_string = nil

      case input
      when 'M'
        operation_string = 'view manifest'
      when 'V'
        operation_string = 'view single order'
      when 'S'
        operation_string = 'search for order by lead traveler'
      when 'H'
        operation_string = 'view help documentation'
      end

      operation_string
    end
  end
end
