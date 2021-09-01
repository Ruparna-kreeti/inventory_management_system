class Employee < ApplicationRecord
  before_save :email_downcase

  validates :name,presence: true
  validates :email,presence: true, uniqueness: true
  validates :status,inclusion: { in: [ true, false ] }

  def email_downcase
      self.email=self.email.downcase
  end

  def get_status
    self.status ? "Active" : "Inactive"
  end

end