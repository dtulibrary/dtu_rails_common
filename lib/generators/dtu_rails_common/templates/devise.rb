Devise.setup do |config|
  require 'devise/orm/active_record'

  config.authentication_keys = [ :identifier ]
  config.sign_out_via        = :get

  cas_url =    Rails.application.config.auth[:cas_url] if Rails.application.config.respond_to?(:auth)
  cas_url ||= 'https://auth.findit.dtu.dk'

  config.omniauth :cas,
                  :host       => cas_url.gsub(/^https?:\/\//, ''),
                  :ssl        => cas_url.start_with?('https://'),
                  :login_url  => '/users/login',
                  :logout_url => '/users/login',
                  :name       => :cas,
                  :setup      => true,
                  :scope      => 'user'
end
