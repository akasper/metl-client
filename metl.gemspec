# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "metl/version"

Gem::Specification.new do |s|
  s.name        = "metl"
  s.version     = Metl::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andrew Kasper", "Paul Bergeron"]
  s.email       = ["andrew.m.kasper@gmail.com", "paul.d.bergeron@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{The Magical Extract/Transform/Load Tool}
  s.description = %q{Raw data goes in. A golden master comes out. You can't explain that.}

  s.rubyforge_project = "metl"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
