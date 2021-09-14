# frozen_string_literal: true

# notification model for employee
class EmployeeNotification < ApplicationRecord
  belongs_to :employee
  belongs_to :issue
end
