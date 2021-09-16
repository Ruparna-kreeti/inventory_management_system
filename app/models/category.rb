# frozen_string_literal: true

# model for category
class Category < ApplicationRecord
  before_save :name_titleize

  has_many :items, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }, format: /\A([a-zA-Z]|[a-zA-Z][. ])+\z/

  scope :order_by_name, -> { order('name ASC') }

  private

  def name_titleize
    self.name = name.titleize
  end
end
