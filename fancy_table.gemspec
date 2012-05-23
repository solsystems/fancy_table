# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fancy_table/version"

Gem::Specification.new do |s|
  s.name        = "fancy_table"
  s.version     = FancyTable::VERSION
  s.authors     = ["Caleb Thompson", "Ram Dobson", "Sol Systems"]
  s.email       = %w{cjaysson@gmail.com fringd@gmail.com gems@solsystemscompany.com}
  s.summary     = %q{Tables. Done right.}
  s.description = <<-DESC.gsub(/\s{2,}/, '')
                    Create fancy tables which are semantic HTML5, are easy to
                    style, and are beautiful.
                  DESC

  s.rubyforge_project = "fancy_table"

  s.files         = Dir["lib/**/*"]
  s.require_path  = "lib"

  s.add_dependency 'squeel'
  s.add_dependency 'haml'
  s.add_dependency 'kaminari'
end
