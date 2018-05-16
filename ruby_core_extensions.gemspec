# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_core_extensions/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby_core_extensions'
  spec.version       = RubyCoreExtensions::VERSION
  spec.authors       = ['Michael Noack', 'Alessandro Berardi']
  spec.email         = 'development@travellink.com.au'
  spec.description   = 'These are extensions from core ruby classes.'
  spec.summary       = 'Set of extensions to core ruby libraries used by TravelLink Technology.'
  spec.homepage      = 'http://github.com/sealink/ruby_core_extensions'

  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 2.0'
  spec.add_dependency 'tzinfo'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'coverage-kit'
  spec.add_development_dependency 'simplecov-rcov'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'travis'
  spec.add_development_dependency 'rubocop-rails'
end
