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
      extra_body_classes.join " "
    end

    ##
    # List of classes to be applied to the <body> element
    # @see render_body_class
    # @return [Array<String>]
    # def extra_body_classes
    #   []
    # end
  end
end
