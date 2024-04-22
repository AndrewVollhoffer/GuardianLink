class ApplicationController < ActionController::Base

    before_action :current_user
    before_action :user_check

    def user_check
        if session[:current_user_id] == nil
            session[:current_user_id] = "guest"
            redirect_to root_path
        end
    end

    private

    def current_user
        @_current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
    end
end
