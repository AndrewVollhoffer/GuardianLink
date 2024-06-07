class ApplicationController < ActionController::Base

    before_action :current_user

    private

    # A reference to the user in the current active session
    def current_user
        @_current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
    end

    # Require that a session is active meaning they are signed in
    def require_user_signed!
        redirect_to log_in_path, alert: "You must be logged in!" if current_user.nil?
    end

    # Check if current user has a completed profile (all required info submitted)
    def profile_completed?(user)
        helpers.profile_completed?(user)
    end
end
