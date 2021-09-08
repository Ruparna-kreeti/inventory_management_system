class Employee < ApplicationRecord
  before_save :email_downcase

  has_and_belongs_to_many :items
  has_many :issues,dependent: :destroy
  has_many :employee_notifications

  validates :name,presence: true
  validates :email,presence: true, uniqueness: true
  validates :status,inclusion: { in: [ true, false ] }

  def email_downcase
      self.email=self.email.downcase
  end

  def get_status
    self.status ? "Active" : "Inactive"
  end

  def self.from_omniauth(auth)
    if Employee.find_by(email: auth.info.email)
      where(email: auth.info.email).first_or_initialize do |user|
        user.name = auth.info.name
        user.email = auth.info.email
      end
    end
  end

end