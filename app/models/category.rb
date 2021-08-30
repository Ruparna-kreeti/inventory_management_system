class Category < ApplicationRecord
  before_save :name_downcase

  validates :name,presence: true,uniqueness: true

  default_scope{order('name ASC')}

  def name_downcase
    self.name=self.name.downcase
  end
  
end