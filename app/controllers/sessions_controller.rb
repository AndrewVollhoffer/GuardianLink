class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.authenticate_by(email: params[:email], password: params[:password])
        if user != nil
            reset_session
            session[:current_user_id] = user.id
            if current_user.admin?
                redirect_to users_path
            else
                redirect_to users_path
                flash[:notice] = 'Welcome back.'
            end
          else
            redirect_to log_in_path
            flash[:notice] = 'E-mail and/or password is incorrect.'
        end
    end

    def destroy
        if current_user.admin? == false ||current_user.admin? == nil || current_user != nil
            session.delete(:current_user_id)
            @_current_user = nil
            redirect_to root_path
            flash[:notice] = 'Goodbye.'
        end
    end

end
