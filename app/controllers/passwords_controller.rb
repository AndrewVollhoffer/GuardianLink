class PasswordsController < ApplicationController

  before_action :require_user_signed!

  def edit
  end

  def update
    respond_to do |format|
      if current_user.update(password_params)
        redirect_to current_user, notice: "Password updated successfully!"
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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
