class AccountMailer < ApplicationMailer
  def new_user_email
    @user=params[:user]
    mail(to: @user.email, subject: "Welcome to inventory management system")
  end
end
