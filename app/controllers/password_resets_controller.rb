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

    respond_to do |format|

      if @user.update(password_params)
        format.html { redirect_to log_in_path, notice: "Password reset successfully!" }
        format.json { render "log-in", status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end

    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
