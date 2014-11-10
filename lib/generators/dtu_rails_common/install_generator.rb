require 'rails/generators'

module DtuRailsCommon
  class Install < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def inject_bootstrap_sass_gem
      append_to_file 'Gemfile' do
        "  gem 'bootstrap-sass'"
      end
    end

    def assets
      copy_file "dtu_bootstrap.css.scss", "app/assets/stylesheets/dtu_bootstrap.css.scss"
      copy_file "dtu_bootstrap.js", "app/assets/javascripts/dtu_bootstrap.js"
    end
  end
end
