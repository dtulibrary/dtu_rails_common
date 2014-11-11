ENV["RAILS_ENV"] ||= 'test'
require 'engine_cart'
EngineCart.load_application!

require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'

require 'dtu_rails_common'

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}
Dir["./spec/matchers/**/*.rb"].sort.each {|f| require f}

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # config.include Controllers::EngineHelpers, type: :controller
  config.include Capybara::DSL
  config.infer_spec_type_from_file_location!
  config.deprecation_stream
end
