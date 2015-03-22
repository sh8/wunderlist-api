# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wunderlist/version'

Gem::Specification.new do |spec|
  spec.name          = "wunderlist-api"
  spec.version       = Wunderlist::VERSION
  spec.authors       = ["shun3475"]
  spec.email         = ["imokenpi3475@gmail.com"]
  spec.summary       = %q{WunderList Ruby API Client.}
  spec.description   = %q{You can manage Your Wunderlist Data with Ruby}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
