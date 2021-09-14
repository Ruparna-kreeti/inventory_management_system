# frozen_string_literal: true

# helper contains method for checking if employee contains item
module ApplicationHelper
  def check_employee_association(object)
    check_if_employee_exists = true
    object.items.each do |item|
      unless item.employees.empty?
        check_if_employee_exists = false
        break
      end
    end
    check_if_employee_exists
  end
end
