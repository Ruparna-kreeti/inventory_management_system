# frozen_string_literal: true

# user sessions controller manages the user login session
class UserSessionsController < ApplicationController
  before_action :check_no_logins, only: [:new]

  def new; end

  def google_auth
    access_token = request.env['omniauth.auth']
    user = User.from_omniauth(access_token)
    employee = Employee.from_omniauth(access_token)
    if user.nil? && employee.nil?
      flash.now[:danger] = 'Not authorized user'
      render 'new'
    else
      redirect_login user, employee, access_token
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, flash: { success: 'Logged out successfully' }
  end

  private

  def check_no_logins
    redirect_to root_path, flash: { danger: 'you are already logged in' } if user_logged_in || employee_logged_in
  end

  def save_respective_user(object, access_token)
    object.google_token = access_token.credentials.token
    refresh_token = access_token.credentials.refresh_token
    object.google_refresh_token = refresh_token if refresh_token.present?
    object.save
    redirect_to root_path, flash: { success: 'Logged in successfully' }
  end

  def employee_login(employee, access_token)
    if employee_logged_in
      save_respective_user employee, access_token
    else
      flash.now[:danger] = 'Inactive employee.Please login as an active employee'
      render 'new'
    end
  end

  def redirect_login(user, employee, access_token)
    if user
      log_in_user user
      save_respective_user user, access_token
    else
      log_in_employee employee
      employee_login employee, access_token
    end
  end
end
