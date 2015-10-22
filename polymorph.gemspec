$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "polymorph/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "polymorph"
  s.version     = Polymorph::VERSION
  s.authors     = ["Nick Ostrovsky"]
  s.email       = ["nick@firedev.com"]
  s.homepage    = "http://firedev.com"
  s.summary     = "Frontend Bits and Pieces for Rails"
  s.description = "http://firedev.com"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4"

  s.add_development_dependency "mysql2", "< 0.4"
end
