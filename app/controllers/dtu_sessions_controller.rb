require 'dtu_rails_common/riyosha'

class DtuSessionsController < DtuApplicationController
  skip_before_action :authenticate,               :only => [ :setup, :create, :new ]
  skip_before_action :authenticate_conditionally, :only => [ :setup, :create, :new ]

  # Called by the user clicking login or by the authorize before_filter
  # (due to forced shunting of dtu users).
  def new
    case
    when params[:only_dtu]
      logger.info "Overriding shunt cookie with value from params. Using DTU CAS"
      session[:only_dtu] = true
    when params[:public]
      logger.info "Overriding shunt cookie with value from params. Using local user"
      session[:public] = true
    when cookies[:shunt] == 'dtu'
      logger.info "Shunt cookie set to 'dtu'. Shunting directly to DTU CAS"
      session[:only_dtu] = true
    when cookies[:shunt_hint] == 'dtu'
      logger.info "Shunt hint cookie set to 'dtu'. Shunting with hint to DTU CAS"
      session[:prefer_dtu] = true
    when campus_request? && !walk_in_request?
      logger.info "Campus request. Shunting with hint to DTU CAS"
      session[:prefer_dtu] = true
    end

    # store given return url in session also, since omniauth-cas in
    # test mode does not pass url parameter back to sessions_controller#create
    url = session[:return_url] = params[:url] || '/'

    redirect_to "#{omniauth_path(:cas)}?#{{ :url => url }.to_query}"
  end

  # Set your omniauth to use this in the setup phase for adding extra parameters
  # to the call to Riyosha. The parameters determine what kind of login options are
  # available when the user is redirected to Riyosha.
  def setup
    case
    when session.delete(:only_dtu)
      request.env['omniauth.strategy'].options[:login_url] = '/login?only=dtu&template=dtu_user'
    when session.delete(:prefer_dtu)
      request.env['omniauth.strategy'].options[:login_url] = '/login?template=dtu_user'
    when session.delete(:public)
      request.env['omniauth.strategy'].options[:login_url] = '/login?template=local_user'
    else
      request.env['omniauth.strategy'].options[:login_url] = '/login'
    end

    render :text => "Omniauth setup phase.", :status => 404
  end

  # Override in your session controller to store user in local storage
  def create_or_update_local_user provider, user_data
    raise 'not implemented'
  end

  # Override in your session controller to find user in local storage
  def find_local_user_by_provider_and_identifier provider, identifier
    raise 'not implemented'
  end

  # Finds user in Riyosha and updates local storage.
  # Raises StandardError if user could not be found.
  def find_and_update_user provider, identifier
    user_data = Riyosha.find( identifier )
    Rails.logger.info "Got user data from Riyosha: #{user_data}"

    user = 
      if user_data
        create_or_update_local_user( provider, user_data )
      else
        logger.warn "Could not get user data from Riyosha."
        find_local_user_by_provider_and_identifier( provider, identifier )
      end

    raise 'login failed' unless user
    session[:user_id] = user.id
    user
  end

  # Set your omniauth-cas to use this as callback_url
  def create
    # extract authentication data
    Rails.logger.info 'Create session'
    auth       = request.env["omniauth.auth"]
    provider   = params['provider']
    identifier = auth.uid
    Rails.logger.info "From omniauth: auth => #{auth}, provider => #{provider}, identifier => #{identifier}"

    begin
      user = find_and_update_user( provider, identifier )
    rescue => e
      logger.error "Error getting/updating user: #{e}"
      redirect_to params[:url] || root_path, :alert => t('dtu.auth.login_failed')
    else
      # Set shunting cookies
      cookies.permanent[:shunt] = cookies.permanent[:shunt_hint] = user.user_data["authenticator"] unless walk_in_request?

      # redirect user to the requested url
      session_return_url = session.delete(:return_url)
      redirect_to params[:url] || session_return_url || root_path, :notice => t('dtu.auth.logged_in')
    end
  end

  def destroy
    destroy_session
    redirect_to logout_url, :notice => t('dtu.auth.logged_out'), :only_path => false
  end

  def omniauth_path(provider, options = {})
    "/auth/#{provider.to_s}"
  end

  def logout_url
    if Rails.application.config.auth[:stub]
      root_url
    else
      service = { :service => root_url }
      "#{Rails.application.config.auth[:cas_url]}/logout?#{service.to_query}"
    end
  end

  private

  def destroy_session
    reset_session
    cookies.delete :shunt
  end

end
