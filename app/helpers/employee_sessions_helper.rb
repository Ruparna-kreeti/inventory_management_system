module EmployeeSessionsHelper
  def log_in_employee employee
    session[:employee_id]=employee.id
  end

  def current_employee
    if session[:employee_id]
      @current_employee||=User.find(session[:employee_id])
    end
  end

  def employee_logged_in
    !current_employee.nil?
  end

end
