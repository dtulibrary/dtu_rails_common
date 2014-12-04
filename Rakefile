begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

begin
  require 'engine_cart/rake_task'
rescue LoadError
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'DtuRailsCommon'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

#APP_RAKEFILE = File.expand_path("../test/dummy/Rakefile", __FILE__)
#load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks

desc 'Continuous integration task'
task :ci => ['engine_cart:clean', 'engine_cart:generate'] do
  exec({ 'RAILS_ENV' => nil }, 'bundle', 'exec', 'rake', 'spec')
end

task default: :ci
