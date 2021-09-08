class EmployeeSessionsController < ApplicationController
  before_action :check_no_logins, only: [:new]
  before_action :check_correct_logout, only: [:destroy]

  def new
  end

  def destroy
    session.delete(:employee_id)
    redirect_to root_path;flash[:success]="Logged out successfully"
  end

  def google_auth
    access_token = request.env["omniauth.auth"]
    employee = Employee.from_omniauth(access_token)
    if employee.nil?
      flash.now[:danger]="Not authorized Employee"
      render 'new'
    else
      log_in_employee employee
      employee.google_token = access_token.credentials.token
      refresh_token = access_token.credentials.refresh_token
      employee.google_refresh_token = refresh_token if refresh_token.present?
      employee.save
      redirect_to root_path;flash[:success]="Logged in successfully"
    end
  end

  private
    def check_no_logins
      if user_logged_in || employee_logged_in
        redirect_to root_path;flash[:danger]="you are already logged in"
      end
    end

    def check_correct_logout
      if !employee_logged_in
        redirect_to root_path;flash[:danger]="you are not logged in as employee"
      end
    end

end
