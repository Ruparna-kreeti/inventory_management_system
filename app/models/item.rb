# frozen_string_literal: true

# model for item
class Item < ApplicationRecord
  before_save :name_downcase

  belongs_to :brand
  belongs_to :category

  has_one_attached :file

  has_one :storage, dependent: :destroy

  has_many :issues, dependent: :destroy

  has_and_belongs_to_many :employees

  validates :notes, presence: true, length: { maximum: 250 }
  validates :buffer_quantity, presence: true

  validates :name, presence: true, uniqueness: { scope: %i[brand_id category_id], message: 'Item already present' }

  def name_downcase
    name.downcase!
  end

  def item_fullname
    "#{brand.name} #{category.name} #{name}"
  end
end
