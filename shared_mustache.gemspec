# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shared_mustache/version'

Gem::Specification.new do |gem|
  gem.name          = "shared_mustache"
  gem.version       = SharedMustache::VERSION
  gem.authors       = ["Edd Sowden"]
  gem.email         = ["edd.sowden@digital.cabinet-office.gov.uk"]
  gem.description   = %q{Share mustache between Rails templates and the browser (using compiled hogan.js templates).}
  gem.summary       = %q{Share mustache between Rails templates and the browser (using compiled hogan.js templates).}
  gem.homepage      = ""

  gem.add_dependency 'mustache', '~> 0.99.4'
  gem.add_dependency 'execjs', '>= 1.2.4'

  gem.add_development_dependency "gem_publisher", "~> 1.1.1"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
