# frozen_string_literal: true

# model for category
class Category < ApplicationRecord
  before_save :name_downcase

  has_many :items, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }, format: /\A([a-zA-Z]|[a-zA-Z][. ])+\z/

  default_scope { order('name ASC') }

  def name_downcase
    self.name = name.downcase
  end
end
