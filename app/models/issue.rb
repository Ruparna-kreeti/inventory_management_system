class Issue < ApplicationRecord
  belongs_to :employee
  belongs_to :item

  attribute :is_solved, :boolean, default: false

  validates :detail,presence: true,length: { maximum: 260}
end