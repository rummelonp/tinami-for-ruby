# -*- coding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tinami/version'

Gem::Specification.new do |spec|
  spec.name        = 'tinami'
  spec.version     = TINAMI::VERSION
  spec.authors     = ['Kazuya Takeshima']
  spec.email       = ['mail@mitukiii.jp']
  spec.summary     = %q{TINAMI is a simple TINAMI API library.}
  spec.description = %q{TINAMI is a simple TINAMI API library.}
  spec.homepage    = 'https://github.com/mitukiii/tinami-for-ruby'
  spec.license     = 'MIT'

  spec.add_runtime_dependency 'rest-client', '~> 1.6.7'
  spec.add_runtime_dependency 'activesupport', '~> 3.1.3'
  spec.add_runtime_dependency 'i18n', '~> 0.6.0'
  spec.add_runtime_dependency 'hashie', '~> 1.2.0'
  spec.add_development_dependency 'rspec', '~> 2.8.0'
end
