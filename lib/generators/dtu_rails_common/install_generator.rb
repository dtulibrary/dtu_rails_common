require 'rails/generators'

module DtuRailsCommon
  class Install < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def assets
      copy_file "dtu_rails_common.css.scss", "app/assets/stylesheets/dtu_rails_common.css.scss"
      copy_file "dtu_rails_common.js", "app/assets/javascripts/dtu_rails_common.js"
    end

  end
end
