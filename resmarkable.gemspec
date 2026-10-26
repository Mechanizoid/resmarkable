# frozen_string_literal: true

require_relative "lib/resmarkable/version"

Gem::Specification.new do |spec|
  spec.name = "resmarkable"
  spec.version = Resmarkable::VERSION
  spec.authors = ["Christopher Phoenix"]
  spec.email = ["hello@chrisphoenix.dev"]

  spec.summary = "An unofficial client library for the Resmark Systems API."
  spec.description = <<~TEXT
    Resmarkable provides a clean, object-orientated API wrapper for interacting
    with the Resmark Systems API. It facilitates retrieving orders, reports, and
    manifests; creating and managing shopping carts; creating orders; and
    cancelling orders.

    As several Resmark Systems API endpoints are poorly documented and/or do not
    behave as expected, this wrapper provides convenience methods to abstract
    away the kludgy workarounds the Resmark Systems support team has recommended
    to me.

    This is an independent, community-driven unofficial client library. It is
    not affiliated with or officially endorsed by Resmark Systems, LLC. Users
    are entirely responsible for adhering to their own Resmark Systems API rate
    limits and terms of service.
  TEXT
  spec.homepage = "https://github.com/Mechanizoid/resmarkable"
  spec.required_ruby_version = ">= 3.2.0"
  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Mechanizoid/resmarkable"
  spec.metadata["changelog_uri"] = "https://github.com/Mechanizoid/resmarkable/blob/main/CHANGELOG.md"
  spec.licenses = "LGPL-3.0-or-later"

  # Uncomment the line below to require MFA for gem pushes.
  # This helps protect your gem from supply chain attacks by ensuring
  # no one can publish a new version without multi-factor authentication.
  # See: https://guides.rubygems.org/mfa-requirement-opt-in/
  # spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/ .rubocop.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://guides.rubygems.org/make-your-own-gem/
end
