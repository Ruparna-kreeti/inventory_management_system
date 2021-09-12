class EmployeeSessionsController < ApplicationController
  before_action :check_no_logins, only: [:new]
  before_action :check_correct_logout, only: [:destroy]

  def new
  end

  def destroy
    session.delete(:employee_id)
    redirect_to root_path, flash: { success: "Logged out successfully" }
  end

  private
    def check_no_logins
      if user_logged_in || employee_logged_in
        redirect_to root_path, flash: { danger: "you are already logged in" }
      end
    end

    def check_correct_logout
      if !employee_logged_in
        redirect_to root_path, flash: { danger: "you are not logged in as employee" }
      end
    end

end
