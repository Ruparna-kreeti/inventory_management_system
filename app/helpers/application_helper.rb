module ApplicationHelper

  def check_employee_association object
    check_if_employee_exists=true
    object.items.each do |item|
      if !item.employees.empty?
        check_if_employee_exists=false
        break
      end
    end
    return check_if_employee_exists
  end

end
