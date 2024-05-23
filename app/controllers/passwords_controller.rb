class PasswordsController < ApplicationController

  before_action :require_user_signed!

  def edit
  end

  def update
    respond_to do |format|
      if current_user.update(password_params)
        format.html { redirect_to user_url(current_user), notice: "Password successfully updated!" }
        format.json { render :show, status: :ok, location: current_user }
      else
        format.html { render :edit, status: :unprocessable_entity }
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
