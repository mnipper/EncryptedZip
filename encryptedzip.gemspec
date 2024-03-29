# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'encryptedzip/version'

Gem::Specification.new do |spec|
  spec.name          = "encryptedzip"
  spec.version       = Encryptedzip::VERSION
  spec.authors       = ["Michael Nipper"]
  spec.email         = ["mjn4406@gmail.com"]
  spec.description   = %q{Created an encrypted zip.}
  spec.summary       = %q{Create an encrypted zip file.  The encrypted zip is then zipped with an encrypted password.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "zipruby", "~> 0.3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
