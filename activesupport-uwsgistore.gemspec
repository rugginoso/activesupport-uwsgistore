# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "activesupport-uwsgistore"
  s.version     = "0.0.2"
  s.authors     = ["Lorenzo Masini"]
  s.email       = ["rugginoso@develer.com"]
  s.homepage    = "http://github.com/rugginoso/activesupport-uwsgistore"
  s.summary     = %q{Cache store that uses uwsgi caching framework}
  s.description = %q{Cache store that uses uwsgi caching framework}

  s.rubyforge_project = "activesupport-uwsgistore"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "activesupport"
  s.add_runtime_dependency "uwsgi"
end
