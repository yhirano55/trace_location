# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trace_location/version'

Gem::Specification.new do |s|
  s.name          = 'trace_location'
  s.version       = TraceLocation::VERSION
  s.authors       = ['Yoshiyuki Hirano']
  s.email         = ['yhirano@me.com']
  s.homepage      = 'https://github.com/yhirano55/trace_location'
  s.summary       = 'logs a tracing result of :call and :return'
  s.description   = %(TraceLocation gem provides logs a tracing result of `:call` and `:return`. It's useful for reading the huge codes (e.g. Ruby on Rails) and tracing its process.)
  s.license       = 'MIT'
  s.files         = Dir.chdir(File.expand_path('.', __dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.5.0'

  s.add_development_dependency 'bundler', '~> 2.0'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
end
