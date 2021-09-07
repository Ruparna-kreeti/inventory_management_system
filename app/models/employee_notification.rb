class EmployeeNotification < ApplicationRecord
  belongs_to :employee
  belongs_to :issue 
end