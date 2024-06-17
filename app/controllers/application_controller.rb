class ApplicationController < ActionController::Base

    before_action :current_user
    before_action :guest_user

    private

    # A reference to the user in the current active session
    def current_user
        @_current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
    end
    helper_method :current_user

    # Creates a guest session if user is not signed in
    def guest_user
        unless user_signed_in?
            session[:current_user_id] = "guest"
        end
    end

    # Require that a session is active meaning they are signed in
    def require_user_signed!
        redirect_to log_in_path, alert: "You must be logged in!" if current_user.nil?
    end

    # Check if current user has a completed profile (all required info submitted)
    def profile_completed?(user)
        if !user.ngo?
            if
                # user.profile_photo.attached? &&
                user.attribute_present?(:first_name) &&
                user.attribute_present?(:last_name) &&
                user.attribute_present?(:hours) &&
                user.attribute_present?(:bio) &&
                user.attribute_present?(:linkedin)
                return true
            end
        elsif user.ngo?
            if
                # user.profile_photo.attached? &&
                user.attribute_present?(:first_name) &&
                user.attribute_present?(:bio)
                return true
            end
        end
    end
    helper_method :profile_completed?

    # Only return true if the user is signed in
    def user_signed_in?
        if @_current_user != nil
            return true
        end
    end
    helper_method :user_signed_in?

end
