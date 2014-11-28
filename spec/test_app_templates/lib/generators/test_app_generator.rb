require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root "./spec/test_app_templates"

  def install_engine
    system('mv ./lib/generators/app/controllers/* ./app/controllers/')
    system('mv ./lib/generators/config/routes.rb ./config/')

    create_file 'app/assets/stylesheets/application.css.scss' do
      "@import 'dtu_rails_common';"
    end
    remove_file 'app/assets/stylesheets/application.css'

    inject_into_file 'app/assets/javascripts/application.js', :before => /\n\s*\/\/= require_tree/ do
      "\n//= require 'dtu_rails_common'"
    end
  end

end
