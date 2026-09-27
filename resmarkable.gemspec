# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'resmarkable/version' if File.exist?('lib/resmarkable/version.rb')

Gem::Specification.new do |spec|
  spec.name          = 'resmarkable'
  spec.version       = '0.1.0'
  spec.authors       = ['Christopher Phoenix']
  spec.email         = ['hello@chrisphoenix.dev']

  spec.summary       = 'An unofficial CLI viewer from Resmark Systems bookings'
  spec.description   = 'An unofficial CLI tool to retrieve and view manifests '\
                       'and single order booking information from the Resmark '\
                       'Systems reservation system API'
  spec.homepage      = 'https://github.com/Mechanizoid/resmarkable'
  spec.license       = 'GPL-3.0'

  spec.required_ruby_version = '>= 3.4.10'

  spec.files = Dir['lib/**/*.rb', 'bin/*', 'README.md', 'Gemfile']

  # Dependencies
  spec.add_dependency              'curses',  '~> 1.7'
  spec.add_dependency              'faraday', '~> 2.14'

  # Development dependencies
  spec.add_development_dependency  'minitest', '~> 6.0'
  
  spec.bindir        = 'bin'
  spec.executables   = ['resmarkable']
  spec.require_paths = ['lib']
end
