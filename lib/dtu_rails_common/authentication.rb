module DtuRailsCommon
  module Authentication

    def authenticate?
      return false if walk_in_request?  
    end

    # Authenticate users if certain criteria are met.
    # - No authentication will be done if user is already logged in.
    # - Force authentication if the shunting cookie indicates
    #   that last successful login was via CAS or
    #   if the user originates from a DTU Campus ip address
    # - Otherwise authentication is optional
    def authenticate
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

      if should_force_authentication
        force_authentication
      end 
    end 

  end
end
