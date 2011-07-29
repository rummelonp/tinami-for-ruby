# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tinami/version"

Gem::Specification.new do |s|
  s.name        = "tinami"
  s.version     = TINAMI::VERSION
  s.authors     = ["Kazuya Takeshima"]
  s.email       = ["mail@mitukiii.jp"]
  s.homepage    = ""
  s.summary     = %q{TINAMI is a simple TINAMI API library.}
  s.description = %q{TINAMI is a simple TINAMI API library.}

  s.rubyforge_project = "tinami"
  s.add_dependency("rest-client")
  s.add_dependency("active_support")
  s.add_dependency("hashie")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
