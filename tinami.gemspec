# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tinami/version"

Gem::Specification.new do |s|
  s.name        = "tinami"
  s.version     = TINAMI::VERSION
  s.authors     = ["Kazuya Takeshima"]
  s.email       = ["mail@mitukiii.jp"]
  s.homepage    = "https://github.com/mitukiii/tinami-for-ruby"
  s.summary     = %q{TINAMI is a simple TINAMI API library.}
  s.description = %q{TINAMI is a simple TINAMI API library.}

  s.rubyforge_project = "tinami"
  s.add_runtime_dependency("rest-client", "~> 1.6.7")
  s.add_runtime_dependency("activesupport", "~> 3.1.3")
  s.add_runtime_dependency("i18n", "~> 0.6.0")
  s.add_runtime_dependency("hashie", "~> 1.2.0")
  s.add_development_dependency("rspec", "~> 2.8.0")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
