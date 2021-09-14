# frozen_string_literal: true

# helper contains method to access all employees
module EmployeesHelper
  def access_employees
    @employees = Employee.all
  end
end
