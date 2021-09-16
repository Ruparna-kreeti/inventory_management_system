# frozen_string_literal: true

# model for employee
class Employee < ApplicationRecord
  before_save :email_downcase

  has_and_belongs_to_many :items
  has_many :issues, dependent: :destroy
  has_many :employee_notifications

  validates :name, presence: true, format: /\A([a-zA-Z]|[a-zA-Z][. ])+\z/
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  validates :status, inclusion: { in: [true, false] }

  def employee_status
    status ? 'Active' : 'Inactive'
  end

  def self.from_omniauth(auth)
    return unless Employee.find_by(email: auth.info.email)

    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
    end
  end

  private

  def email_downcase
    self.email = email.downcase
  end
end
