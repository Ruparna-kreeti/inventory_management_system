class EmployeeSessionsController < ApplicationController
  before_action :check_no_logins, only: [:new, :create]
  before_action :check_correct_logout, only: [:destroy]
  def new
  end

  def create
    employee=Employee.find_by_email(params[:email].downcase)
    if employee
      log_in_employee employee
      redirect_to root_path;flash[:success]="Logged in successfully"
    else
      flash.now[:danger]="Not authorized Employee"
      render 'new'
    end
  end

  def destroy
    session.delete(:employee_id)
    redirect_to root_path;flash[:success]="Logged out successfully"
  end

  def googleAuth
    # Get access tokens from the google server
    access_token = request.env["omniauth.auth"]
    employee = Employee.from_omniauth(access_token)
    if employee.nil?
      flash.now[:danger]="Not authorized Employee"
      render 'new'
    else
      log_in_employee employee
      # Access_token is used to authenticate request made from the rails application to the google server
      employee.google_token = access_token.credentials.token
      # Refresh_token to request new access_token
      # Note: Refresh_token is only sent once during the first request
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
