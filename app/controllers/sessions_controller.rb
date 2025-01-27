class SessionsController < ApplicationController

    def new
    end

    def create
        # Authenticate with authenticate_by with will find and return a user with timed attack protection
        user = User.authenticate_by(email: params[:email], password: params[:password])
        if user != nil
            reset_session
            session[:current_user_id] = user.id
            # Redirect to admin index
            if current_user.admin?
                redirect_to users_path
            else
                # Redirect depending on the state of the user's profile, either cards view or their profile
                if profile_completed?(user) then redirect_to users_path else redirect_to user end
                flash[:notice] = 'Welcome back.'
            end
        else
            redirect_to log_in_path
            flash[:notice] = 'E-mail and/or password is incorrect.'
        end
    end

    def destroy
        if current_user.admin? == false || current_user.admin? == nil || current_user != nil
            session.delete(:current_user_id)
            @_current_user = nil
            redirect_to root_path
            flash[:notice] = 'Goodbye.'
        end
    end

    private

end
