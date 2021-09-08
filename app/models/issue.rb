class Issue < ApplicationRecord
  belongs_to :employee
  belongs_to :item

  attribute :is_solved, :boolean, default: false
  has_many :employee_notifications,dependent: :destroy

  validates :detail,presence: true,length: { maximum: 260}

  def get_solved_status
    self.is_solved ? "Solved" : "Not Solved"
  end

end