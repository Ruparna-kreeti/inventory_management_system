# frozen_string_literal: true

# model for association of employee and item
class EmployeesItem < ApplicationRecord
  after_save :decrement_storage_quantity
  validate :validate_item_storage
  belongs_to :employee
  belongs_to :item

  validates :item_id, presence: true, uniqueness: { scope: [:employee_id], message: 'already assigned to employee' }

  def validate_item_storage
    return if item.storage&.quantity&.positive?

    errors.add :item_id, 'not present or more quantity need to be stacked in storage'
  end

  def item_status
    status ? 'working' : 'not working'
  end

  def decrement_storage_quantity
    item.storage.decrement!(:quantity)
  end
end
