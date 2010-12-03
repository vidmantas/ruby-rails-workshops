# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "workshopygravatar/version"

Gem::Specification.new do |s|
  s.name        = "workshopygravatar"
  s.version     = Workshopygravatar::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Vidmantas"]
  s.email       = ["vidmantas@kabosis.lt"]
  s.homepage    = "http://workshops.emptydot.com"
  s.summary     = %q{A gem to display gravatars}
  s.description = %q{Rails3 helper to display gravatars}

  s.rubyforge_project = "workshopygravatar"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
