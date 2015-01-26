module DtuRailsCommon
  module Authentication

    # Determine whether or not the user should be directed to log in.
    # The user is directed to log in if:
    # - He has previously logged in using DTU CAS.
    # - He has not yet logged in (no shunt cookie) and he is coming from a known DTU IP address
    def authenticate?
      return false if walk_in_request?  
      (cookies[:shunt] == 'dtu') || (!cookies.has_key?(:shunt) && campus_request?)
    end

    # Authenticate users if certain criteria are met.
    # - No authentication will be done if user is already logged in.
    # - Authenticate if the shunting cookie indicates
    #   that last successful login was via CAS or
    #   if the user originates from a DTU Campus ip address
    # - Otherwise authentication is optional
    def authenticate_conditionally
      # This suppresses the log in suggestion on subsequent
      # request if the user clicks "No"
      if params[:stay_anonymous]
        cookies[:shunt_hint] = 'anonymous'
        logger.info "Suppressing log in suggestion"
        redirect_to url_for(params.except!(:stay_anonymous))
      end 

      if params[:public]
        cookies[:shunt_hint] = 'public'
        redirect_to url_for(params.except!(:public))
      end 

      if authenticate?
        authenticate
      end 
    end 

    def authenticate
      params[:url] = request.url
      redirect_to respond_to?(:new_session_path) ? new_session_path(params) : "/sessions/new?#{params.to_query}" unless session[:user_id]
    end
  end
end
