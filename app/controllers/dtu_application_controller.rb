class DtuApplicationController < ActionController::Base
  include DtuRailsCommon::Controller

  before_filter :set_locale

end
