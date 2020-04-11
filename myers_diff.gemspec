# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'myers_diff/version'

Gem::Specification.new do |spec|
  spec.name          = "myers_diff"
  spec.version       = MyersDiff::VERSION
  spec.authors       = ["Eiji MATSUMOTO"]
  spec.email         = ["e.mattsan@gmail.com"]

  spec.summary       = %q{Myers' Diff Algorithm.}
  spec.description   = %q{Myers' Diff Algorithm.}
  spec.homepage      = "https://github.com/mattsan/ruby_myers_diff"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
