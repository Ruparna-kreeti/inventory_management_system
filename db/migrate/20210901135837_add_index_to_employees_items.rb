class AddIndexToEmployeesItems < ActiveRecord::Migration[6.1]
  def change
    add_index :employees_items, [:employee_id, :item_id], unique: true
  end
end
