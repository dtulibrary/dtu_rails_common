$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dtu_rails_common/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dtu_rails_common"
  s.version     = DtuRailsCommon::VERSION
  s.authors     = ["Franck Falcoz", "Matt Zumwalt", "Steffen Elberg Godskesen"]
  s.email       = ["frafa@dtic.dtu.dk", "matt.zumwalt@gmail.com", "sego@dtic.dtu.dk"]
  s.homepage    = "https://github.com/dtulibrary/dtu_rails_common"
  s.summary     = "Layout, css, and authentication for DTU Library applications"
  s.description = %q{A rails engine that provides common layout, css, and authentication for DTU Library applications}
  s.license     = "MIT"

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 4.1.5"
  s.add_dependency "bootstrap-sass", "~> 3.3.0"
  s.add_dependency 'sass-rails', '>= 3.2'

  s.add_development_dependency "sqlite3"
end
