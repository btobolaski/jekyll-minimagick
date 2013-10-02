# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jekyll-retinamagick/version"

Gem::Specification.new do |s|
  s.name        = "jekyll-retinamagick"
  s.version     = Jekyll::Retinamagick::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brendan Tobolaski"]
  s.email       = ["brendan@tobolaski.com"]
  s.homepage    = "http://github.com/btobolaski/jekyll-retinamagick"
  s.summary     = %q{MiniMagick integration, including retina support, for Jekyll}
  s.description = %q{Use MiniMagick to create the image sizes that you need. A fork of jekyll-minimagick.}

  s.rubyforge_project = "jekyll-retinamagick"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency('jekyll', [">= 0.10.0"])
  s.add_runtime_dependency('mini_magick', [">= 3.3"])
end
