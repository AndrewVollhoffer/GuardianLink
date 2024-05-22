class ApplicationController < ActionController::Base

    before_action :current_user

    private

    def current_user
        @_current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
    end

    def require_user_signed!
        redirect_to log_in_path, alert: "You must be logged in!" if current_user.nil?
    end

end
