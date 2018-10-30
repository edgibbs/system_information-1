# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'system_information/version'

Gem::Specification.new do |spec|
  spec.name = 'system_information'
  spec.version = SystemInformation::VERSION
  spec.authors = ['Ed Gibbs']
  spec.email = ['ed@edgibbs.com']

  spec.summary = 'A gem to provide health checks for CWDS products'
  spec.description = <<-TEXT
   Adds a /system-information endpoint to perform health checks. Designed to be
   used by monitoring services such as New Relic and load balancer checks.
  TEXT
  spec.homepage      = 'https://github.com/ca-cwds'
  spec.license       = 'AGPL-3.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rack', '>= 2.0.1'
  spec.add_dependency 'redis', '>= 4.0.2'

  spec.add_development_dependency 'bundler', '~> 1.17.1'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'timecop'
end
