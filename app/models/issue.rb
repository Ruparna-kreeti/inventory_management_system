# frozen_string_literal: true

# model for issue
class Issue < ApplicationRecord
  belongs_to :employee
  belongs_to :item

  attribute :is_solved, :boolean, default: false
  has_many :employee_notifications, dependent: :destroy

  validates :detail, presence: true, length: { maximum: 260 }

  def issue_solved_status
    is_solved ? 'Solved' : 'Not Solved'
  end
end
