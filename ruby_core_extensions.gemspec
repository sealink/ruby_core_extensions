# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = 'ruby_core_extensions'
  spec.version       = '0.0.1'
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
end
