# frozen_string_literal: true

# employee sessions controller manages employee login
class EmployeeSessionsController < ApplicationController
  before_action :check_no_logins, only: [:new]
  before_action :check_correct_logout, only: [:destroy]

  def destroy
    session.delete(:employee_id)
    redirect_to root_path, flash: { success: 'Logged out successfully' }
  end

  private

  def check_no_logins
    redirect_to root_path, flash: { danger: 'you are already logged in' } if user_logged_in || employee_logged_in
  end

  def check_correct_logout
    redirect_to root_path, flash: { danger: 'you are not logged in as employee' } unless employee_logged_in
  end
end
