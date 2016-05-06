# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scythe/version'

Gem::Specification.new do |spec|
  spec.name          = "scythe"
  spec.version       = Scythe::VERSION
  spec.authors       = ["David Andersen"]
  spec.email         = ["davidx@gmail.com"]

  spec.summary       = %q{Terminate cloud instances}
  spec.description   = %q{Every garden needs a good trimming.}
  spec.homepage      = "http://example.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit"
  spec.add_runtime_dependency 'dust', '~> 0'
  spec.add_runtime_dependency 'fog-aws', '~> 0'
  spec.add_runtime_dependency 'choice', '~> 0.2', '>= 0.2.0'
  spec.add_runtime_dependency 'log4r', '~> 1.1', '>= 1.1.10'
  spec.add_runtime_dependency 'highline', '~> 0'
  spec.add_dependency 'activesupport', '>= 4.0', '< 5.0'

end
