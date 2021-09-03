module EmployeesHelper

  def access_employees
    @employees=Employee.all
  end
  
end
