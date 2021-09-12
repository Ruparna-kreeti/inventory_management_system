class Category < ApplicationRecord
  before_save :name_downcase

  has_many :items,dependent: :destroy
  validates :name,presence: true,:uniqueness =>{:case_sensitive => false}

  default_scope{order('name ASC')}

  def name_downcase
    self.name=self.name.downcase
  end
  
end