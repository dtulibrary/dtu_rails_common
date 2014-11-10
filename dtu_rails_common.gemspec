$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dtu_rails_common/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dtu_rails_common"
  s.version     = DtuRailsCommon::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of DtuRailsCommon."
  s.description = "TODO: Description of DtuRailsCommon."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.5"
  s.add_dependency "bootstrap-sass", "~> 3.3.0"
  s.add_dependency 'sass-rails', '>= 3.2'

  s.add_development_dependency "sqlite3"
end
