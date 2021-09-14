# frozen_string_literal: true

# migration for adding index to employee id and item id
class AddIndexToEmployeesItems < ActiveRecord::Migration[6.1]
  def change
    add_index :employees_items, %i[employee_id item_id], unique: true
  end
end
