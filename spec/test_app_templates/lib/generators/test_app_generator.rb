require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root "./spec/test_app_templates"

  def install_engine
    system('mv ./lib/generators/app/controllers/* ./app/controllers/')
    system('mv ./lib/generators/config/routes.rb ./config/')

    generate 'dtu_rails_common:install'
  end

end
