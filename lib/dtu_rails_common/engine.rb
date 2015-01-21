require 'dtu_rails_common/controller'

module DtuRailsCommon
  class Engine < ::Rails::Engine

    initializer "dtu_rails_common.controller_helpers" do
      ActiveSupport.on_load(:action_controller) do
        include DtuRailsCommon::Controllers::Helpers
      end
    end

  end
end
