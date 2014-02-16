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

  spec.add_runtime_dependency 'faraday', '~> 0.8.9'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.9.0'
  spec.add_runtime_dependency 'multi_xml', '~> 0.5.5'
  spec.add_runtime_dependency 'hashie', '~> 2.0.5'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'ox'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'yard'
end
