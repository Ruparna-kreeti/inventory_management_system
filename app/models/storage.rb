class Storage < ApplicationRecord
  validate :validate_procurement_date

  belongs_to :item

  has_many :admin_notifications,dependent: :nullify
  
  validates :item_id,presence: true,uniqueness: true
  validates :quantity,presence: true
  validates :procurement_date,presence: true

  def convert_date
    begin
      self.procurement_date <= Time.now && self.procurement_date >= Time.now.ago(20.years) 
    rescue ArgumentError
      false
    end
  end

  def validate_procurement_date
    errors.add("Procurement date", "must be within current date to 20years before(Ex if today:1/1/2021 then date within 1/1/2001-1/1/2021)") unless convert_date
  end

end