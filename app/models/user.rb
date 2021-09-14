# frozen_string_literal: true

# model for user
class User < ApplicationRecord
  before_save :email_downcase

  attribute :admin, :boolean, default: false

  has_secure_password

  has_one :section, dependent: :destroy

  has_many :admin_notifications, dependent: :destroy

  validates :name, presence: true, format: /\A[a-zA-Z][a-zA-Z. ]*\z/
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def email_downcase
    self.email = email.downcase
  end

  def self.from_omniauth(auth)
    return unless User.find_by(email: auth.info.email)

    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password_digest = digest(new_token)
    end
  end
end
