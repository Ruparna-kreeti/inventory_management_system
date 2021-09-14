# frozen_string_literal: true

# mailer after new account is created
class AccountMailer < ApplicationMailer
  def new_user_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to inventory management system')
  end
end
