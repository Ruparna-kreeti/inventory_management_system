# frozen_string_literal: true

# model for item
class Item < ApplicationRecord
  before_save :name_titleize

  belongs_to :brand
  belongs_to :category

  has_one_attached :file

  has_one :storage, dependent: :destroy

  has_many :issues, dependent: :destroy

  has_and_belongs_to_many :employees

  validates :notes, presence: true, length: { maximum: 250 }
  validates :buffer_quantity, presence: true

  validates :name, presence: true, uniqueness: { scope: %i[brand_id category_id], message: 'Item already present' }

  def item_fullname
    "#{brand.name} #{category.name} #{name}"
  end

  private

  def name_titleize
    self.name = name.titleize
  end
end
