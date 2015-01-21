require 'dtu_rails_common/ip_classification'
require 'dtu_rails_common/authentication'

module DtuRailsCommon
  module Controller
    extend ActiveSupport::Concern

    included do
      include DtuRailsCommon::IpClassification
      include DtuRailsCommon::Authentication
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def current_locale
      I18n.locale
    end

    def campus_request?
      ip_in? :campus
    end

    def walk_in_request?
      ip_in? :walk_in
    end

  end
end
