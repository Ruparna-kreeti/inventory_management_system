class Brand < ApplicationRecord
  before_save :name_humanize

  validates :name,presence: true,uniqueness: true

  default_scope{order('name ASC')}

  def name_humanize
    self.name=self.name.humanize
  end
end