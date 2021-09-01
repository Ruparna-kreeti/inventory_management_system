class Item < ApplicationRecord
  before_save :name_downcase

  belongs_to :brand
  belongs_to :category

  has_one_attached :file

  validates :notes,presence: true, length: {maximum: 250}
  validates :buffer_quantity,presence: true

  validates :name,presence: true, uniqueness: {scope: [:brand_id, :category_id],message:"Item already present" }

  def name_downcase
    self.name.downcase!
  end

end