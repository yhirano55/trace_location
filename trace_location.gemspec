# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trace_location/version'

Gem::Specification.new do |s|
  s.name          = 'trace_location'
  s.version       = TraceLocation::VERSION
  s.authors       = ['Yoshiyuki Hirano', 'Misaki Shioi']
  s.email         = ['yhirano@me.com', 'shioi.mm@gmail.com']
  s.homepage      = 'https://github.com/yhirano55/trace_location'
  s.summary       = 'helps you get tracing the source location of codes'
  s.description   = %(TraceLocation helps you get tracing the source location of codes, and helps you can get reading the huge open souce libraries in Ruby)
  s.license       = 'MIT'
  s.files         = Dir.chdir(File.expand_path('.', __dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 2.6.0'

  s.add_dependency 'method_source'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
