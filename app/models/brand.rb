class Brand < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name,presence: true,:uniqueness =>{:case_sensitive => false}

  default_scope{order('name ASC')}

end