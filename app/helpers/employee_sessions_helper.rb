# frozen_string_literal: true

# helper for containing employee sessions methods
module EmployeeSessionsHelper
  def log_in_employee(employee)
    session[:employee_id] = employee.id if employee.status
  end

  def current_employee
    @current_employee ||= Employee.find(session[:employee_id]) if session[:employee_id]
  end

  def employee_logged_in
    !current_employee.nil?
  end
end
