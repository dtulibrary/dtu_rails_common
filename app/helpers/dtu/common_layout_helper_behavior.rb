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
    #    the Rails configuration by setting
    #
    #    Rails.application.config.dtu_common_layout = {
    #      :dtu_font_enabled => true
    #    }
    #
    # @return [Boolean] true if the DTU font is enabled and false otherwise

    def dtu_font_enabled?
      !Rails.env.development? || (Rails.application.config.try(:dtu_common_layout) && Rails.application.config.dtu_common_layout[:dtu_font_enabled])
    end

  end
end
