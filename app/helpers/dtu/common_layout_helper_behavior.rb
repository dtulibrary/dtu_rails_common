module Dtu
  module CommonLayoutHelperBehavior

    ##
    # Get the name of this application, from either:
    #  - the Rails configuration
    #  - an i18n string (key: dtu.application_name; preferred)
    #
    # @return [String] the application name
    def application_name
      return Rails.application.config.application_name if Rails.application.config.respond_to? :application_name

      t('dtu.application_name')
    end

    ##
    # Render classes for the <body> element
    # @return [String]
    def render_body_class
      if respond_to? :extra_body_classes
        extra_body_classes.join " "
      else
        ""
      end
    end

    ##
    # Determine whether or not the DTU font is enabled
    #  - For non-development environments it is always enabled
    #  - For development environment it can be enabled through
    #    by using an initializer similar to
    #
    #    module DtuRailsCommon
    #      class Engine < Rails::Engine
    #        config.dtu_font_enabled = Rails.application.config.dtu_font_enabled
    #      end
    #    end
    #
    # @return [Boolean] true if the DTU font is enabled and false otherwise

    def dtu_font_enabled?
      !Rails.env.development? || Rails.application.config.dtu_font_enabled
    end

  end
end
