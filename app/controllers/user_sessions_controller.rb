class UserSessionsController < ApplicationController
  before_action :check_no_logins, only: [:new]
  before_action :check_correct_logout, only: [:destroy]

  def new
  end

  def google_auth
    access_token = request.env["omniauth.auth"]
    user = User.from_omniauth(access_token)
    employee=Employee.from_omniauth(access_token)
    if user.nil? && employee.nil?
      flash.now[:danger]="Not authorized user"
      render 'new'
    elsif user
      session[:user_id]=user.id
      user.google_token = access_token.credentials.token
      refresh_token = access_token.credentials.refresh_token
      user.google_refresh_token = refresh_token if refresh_token.present?
      user.save
      redirect_to root_path;flash[:success]="Logged in successfully"
    else
      log_in_employee employee
      employee.google_token = access_token.credentials.token
      refresh_token = access_token.credentials.refresh_token
      employee.google_refresh_token = refresh_token if refresh_token.present?
      employee.save
      redirect_to root_path;flash[:success]="Logged in successfully"
    end
  end
  
  def destroy
    session.delete(:user_id)
    redirect_to root_path;flash[:success]="Logged out successfully"
  end

  private
    def check_no_logins
      if user_logged_in || employee_logged_in
        redirect_to root_path;flash[:danger]="you are already logged in"
      end
    end

    def check_correct_logout
      if !user_logged_in
        redirect_to root_path;flash[:danger]="you are not logged in as a main user"
      end
    end

end
