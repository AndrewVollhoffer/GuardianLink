class PasswordsController < ApplicationController

  # Ensure the user is signed in before they are allowed to change their password
  before_action :require_user_signed!

  def edit
  end

  def update
    # respond_to still functions properly with Turbo drive off here. Remove respond_to and formatting if styling breaks
    # or it fails
    respond_to do |format|
      if current_user.update(password_params)
        format.html { redirect_to user_url(current_user), notice: "Password successfully updated!" }
        format.json { render :show, status: :ok, location: current_user }
      else
        # Session errors had to be used to preserve Bootstrap styling
        session[:errors] = current_user.errors.full_messages
        format.html { redirect_back fallback_location: current_user }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def password_params
    params.require(:user).permit(
      :password,
      :password_confirmation,
      :password_challenge).with_defaults(password_challenge: '')
  end

end
