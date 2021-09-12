module EmployeeSessionsHelper
  def log_in_employee employee
    if employee.status
      session[:employee_id]=employee.id
    end
  end

  def current_employee
    if session[:employee_id]
      @current_employee||=Employee.find(session[:employee_id])
    end
  end

  def employee_logged_in
    !current_employee.nil?
  end

end
