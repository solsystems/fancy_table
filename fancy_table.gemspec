# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fancy_table/version"

Gem::Specification.new do |s|
  s.name        = "fancy_table"
  s.version     = FancyTable::VERSION
  s.authors     = ["Caleb Thompson", "Ram Dobson", "Sol Systems"]
  s.email       = ["cjaysson@gmail.com", "fringd@gmail.com", "gems@solsystemscompany.com"]
  s.homepage    = ""
  s.summary     = %q{Tables. Done right.}
  s.description = %q{Create fancy tables which are semantic HTML5, are easy to style, and are beautiful.}

  s.rubyforge_project = "fancy_table"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'squeel'
  s.add_dependency 'haml'
  s.add_dependency 'kaminari'
  s.add_dependency 'rails'
  s.add_dependency 'sass-rails'

end
