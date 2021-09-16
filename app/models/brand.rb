# frozen_string_literal: true

# model for brand
class Brand < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :order_by_name, -> { order('name ASC') }
end
