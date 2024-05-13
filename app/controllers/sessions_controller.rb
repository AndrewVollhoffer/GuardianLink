class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(email: params[:email])
        if user != nil && user.authenticate(params[:password])
            session[:current_user_id] = user.id
            if current_user.admin?
                redirect_to users_path
            else
                redirect_to user
                flash[:notice] = 'Welcome back.'
            end
          else
            redirect_to log_in_path
            flash[:notice] = 'E-mail and/or password is incorrect.'
        end
    end

    def destroy
        if helpers.signed_user.admin? == false || helpers.signed_user != nil
            session.delete(:current_user_id)
            @_current_user = nil
            redirect_to root_path
            flash[:notice] = 'Goodbye.'
        end
    end
end
