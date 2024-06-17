class PasswordResetsController < ApplicationController

  def new
  end

  def create
    @email = params[:email]
    @user = User.find_by(email: @email)

    if @user.present?
      PasswordMailer.with(user: @user).reset.deliver_later
    end

    redirect_to log_in_path, notice: "Sent password reset link to #{@email}. If an account exists, you will see it soon!"
  end

  def edit
    # Signed token passed from form
    @token = params[:token]
    # Finds the user through a signed token to ensure there was no value injection
    @user = User.find_signed!(@token, purpose: "password_reset")

  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to log_in_path, alert: "This token has expired. Please try again!"
  end

  def update
    @token = params[:token]
    @user = User.find_signed!(@token, purpose: "password_reset")

    if @user.update(password_params)
      redirect_to log_in_path, notice: "Password reset successfully! Please sign in."
    else
      session[:errors] = @user.errors.full_messages
      redirect_back fallback_location: log_in_path
    end

    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to log_in_path, alert: "This token has expired. Please try again!"

  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
