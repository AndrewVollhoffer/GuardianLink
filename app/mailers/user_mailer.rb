class UserMailer < ApplicationMailer

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome to GuardianLink!")
  end

  def delete_email
    @user = params[:user]
    mail(to: @user.email, subject: "Goodbye, GuardianLink!")
  end

end
