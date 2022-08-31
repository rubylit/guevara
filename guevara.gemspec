# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guevara/version'

Gem::Specification.new do |spec|
  spec.name          = "guevara"
  spec.version       = Guevara::VERSION
  spec.authors       = ["Gaston Ramos", "Eloy Espinaco"]
  spec.email         = ["ramos.gaston@gmail.com", "eloyesp@gmail.com"]
  spec.summary       = %q{Build nacha files.}
  spec.description   = %q{Hide the uglyness of nacha file format.}
  spec.homepage      = "http://github.com/rubylit/guevara"
  spec.license       = "GPL-3.0-or-later"

  spec.files         = Dir['lib/**/*.rb']

  spec.add_development_dependency "bundler", "~> 2.2", ">= 2.2.10"
  spec.add_development_dependency "rake",    "~> 13.0"
  spec.add_development_dependency "cutest",  "~>1.2"
end
