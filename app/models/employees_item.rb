class EmployeesItem < ApplicationRecord
  belongs_to :employee 
  belongs_to :item

  validates :item_id,presence: true, uniqueness: {scope: [:employee_id],message:"already assigned to employee" }

  def get_status
    self.status ? "working" : "not working"
  end
  
end