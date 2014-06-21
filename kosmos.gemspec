# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kosmos/version'

Gem::Specification.new do |spec|
  spec.name          = "kosmos"
  spec.version       = Kosmos::VERSION
  spec.authors       = ["Ulysse Carion"]
  spec.email         = ["ulyssecarion@gmail.com"]
  spec.summary       = %q{The simple package manager for Kerbal Space Program.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rubyzip"
  spec.add_dependency "httparty"
  spec.add_dependency "nokogiri"
  spec.add_dependency "damerau-levenshtein"
  spec.add_dependency "sinatra"
  spec.add_dependency "thin"
end
