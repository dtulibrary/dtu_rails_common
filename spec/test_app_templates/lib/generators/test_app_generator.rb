require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root "./spec/test_app_templates"

  # if you need to generate any additional configuration
  # into the test app, this generator will be run immediately
  # after setting up the application

  def install_engine
    system('mv ./lib/generators/app/controllers/* ./app/controllers/')
    system('mv ./lib/generators/config/routes.rb ./config/')

    #system('rm -f ./app/assets/stylesheets/application.css')
    #system('mv ./lib/generators/app/assets/stylesheets/* ./app/assets/stylesheets/')

    # system('mv ./lib/generators/app/assets/javascripts/* ./app/assets/javascripts/')

    generate 'dtu_rails_common:install'
  end
end
